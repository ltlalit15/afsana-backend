import db from '../config/db.js'
import { universityNameById, StudentNameById, StudentInvoiceById } from '../models/universities.model.js';
import { BranchNameById } from '../models/universities.model.js';
import cloudinary from 'cloudinary';
import fs from 'fs';

cloudinary.config({
    cloud_name: 'dkqcqrrbp',
    api_key: '418838712271323',
    api_secret: 'p12EKWICdyHWx8LcihuWYqIruWQ',
});

export const createPayment = async (req, res) => {
    const {
        branch,
        name,
        whatsapp,
        email,
        groupName,
        university = 0,
        universityOther,
        country,
        countryOther,
        paymentMethod,
        paymentMethodOther,
        paymentType,
        paymentTypeOther,
        assistant,
        note,

    } = req.body;




    let filePath = '';

    // ✅ Upload to Cloudinary if file is provided
    if (req.files && req.files.file) {
        const file = req.files.file;
        try {
            const uploadResult = await cloudinary.uploader.upload(file.tempFilePath, {
                folder: 'payment_files', // your Cloudinary folder name
            });
            filePath = uploadResult.secure_url;
            fs.unlinkSync(file.tempFilePath); // Clean temp file
        } catch (err) {
            console.error("Cloudinary Upload Error:", err);
            return res.status(500).json({ message: 'File upload failed' });
        }
    }

    // Validate required fields


    try {
        const query = `
            INSERT INTO payments (
                branch, name, whatsapp, email, group_name, university, university_other, 
                country, country_other, payment_method, payment_method_other, payment_type, 
                payment_type_other, assistant, note, file 
            ) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )
        `;

        const values = [
            branch, name, whatsapp, email, groupName, university, universityOther,
            country, countryOther, paymentMethod, paymentMethodOther, paymentType,
            paymentTypeOther, assistant, note, filePath,
        ];

        const [result] = await db.query(query, values);

        res.status(201).json({ message: "Payment created successfully", paymentId: result.insertId });

    } catch (error) {
        console.error("Error in createPayment: ", error);
        res.status(500).json({ error: "Internal Server Error", details: error.message });
    }
};

export const getPayments = async (req, res) => {
    try {
        const query = `
            SELECT * FROM payments
        `;
        const [payments] = await db.query(query);
        const data = await Promise.all(
            payments.map(async (task) => {
                const university_id = task.university;
                const branch = task.branch;
                const student_id = task.name
                const university_name = await universityNameById(university_id);
                const branch_name = await BranchNameById(branch);
                const student_name = await StudentNameById(student_id)
                const data = await StudentInvoiceById(student_id)
                console.log(branch_name)
                return {
                    ...task,
                    // file: task.file ? `${req.protocol}://${req.get('host')}${task.file}` : null,
                    file: task.file?.startsWith('http')
                        ? task.file
                        : `${req.protocol}://${req.get('host')}${task.file}`,

                    universityName: university_name[0]?.name || '',
                    branch_name: branch_name[0]?.branch_name,
                    name: student_name[0]?.full_name,
                    student_id: student_name[0]?.student_id,
                    payment_amount: data[0]?.payment_amount,
                    tax: data[0]?.tax,
                    total: data[0]?.total,
                    additional_notes: data[0]?.additional_notes,
                    isInvoiceView: data[0]?.isInvoiceView,
                    payment_date: data[0]?.payment_date,
                };
            })
        );
        res.status(200).json(data);
    } catch (error) {
        console.error("Error in getPayments: ", error);
        res.status(500).json({ error: "Internal Server Error", details: error.message });
    }
};

// export const getPaymentsByid = async (req, res) => {
//     try {
//         const { student_id } = req.params;
//         const query = `SELECT * FROM payments WHERE name = ?`;
//         const [payments] = await db.query(query, [student_id]);
//         const data = await Promise.all(
//             payments.map(async (task) => {
//                 const university_id = task.university;
//                 const branch = task.branch;
//                 const student_id = task.name
//                 const university_name = await universityNameById(university_id);
//                 const branch_name = await BranchNameById(branch);
//                 const student_name = await StudentNameById(student_id)
//                 const data = await StudentInvoiceById(student_id)
//                 console.log(branch_name)
//                 return {
//                     ...task,
//                     // file: task.file ? `${req.protocol}://${req.get('host')}${task.file}` : null,

//          file: task.file?.startsWith('http')
//                         ? task.file
//                         : `${req.protocol}://${req.get('host')}${task.file}`,

//                     universityName: university_name[0]?.name || '',
//                     branch_name: branch_name[0].branch_name,
//                     name: student_name[0].full_name,
//                     student_id: student_name[0].student_id,
//                     payment_amount: data[0].payment_amount,
//                     tax: data[0].tax,
//                     total: data[0].total,
//                     additional_notes: data[0].additional_notes,
//                     isInvoiceView: data[0].isInvoiceView,
//                     payment_date: data[0].payment_date,
//                 };
//             })
//         );
//         res.status(200).json(data);

//     } catch (error) {
//         console.error("Error in getPayments: ", error);
//         res.status(500).json({ error: "Internal Server Error", details: error.message });
//     }
// };



export const getPaymentsByid = async (req, res) => {
    try {
        const { student_id } = req.params;
        const query = `SELECT * FROM payments WHERE name = ?`;
        const [payments] = await db.query(query, [student_id]);

        const data = await Promise.all(
            payments.map(async (task) => {
                const university_id = task.university;
                const branch = task.branch;
                const student_id = task.name;

                const university_name = await universityNameById(university_id);
                const branch_name = await BranchNameById(branch);
                const student_name = await StudentNameById(student_id);
                const invoiceData = await StudentInvoiceById(student_id);

                const invoice = invoiceData?.[0] || {};

                return {
                    ...task,
                    file: task.file?.startsWith('http')
                        ? task.file
                        : `${req.protocol}://${req.get('host')}${task.file}`,

                    universityName: university_name?.[0]?.name || '',
                    branch_name: branch_name?.[0]?.branch_name || '',
                    name: student_name?.[0]?.full_name || '',
                    student_id: student_name?.[0]?.student_id || '',

                    payment_amount: invoice.payment_amount || 0,
                    tax: invoice.tax || 0,
                    total: invoice.total || 0,
                    additional_notes: invoice.additional_notes || '',
                    isInvoiceView: invoice.isInvoiceView || false,
                    payment_date: invoice.payment_date || null,
                };
            })
        );

        res.status(200).json(data);
    } catch (error) {
        console.error("Error in getPayments: ", error);
        res.status(500).json({ error: "Internal Server Error", details: error.message });
    }
};



export const getPaymentByEmail = async (req, res) => {
    const { email } = req.params;

    try {
        const query = `
            SELECT * FROM payments WHERE email = ?
        `;

        const [payments] = await db.query(query, [email]);

        // payments.forEach(payment => {
        //     if (payment.file) {
        //         payment.file = `${req.protocol}://${req.get('host')}${payment.file}`;
        //     }
        // });

        // res.status(200).json(payments);

        const data = await Promise.all(
            payments.map(async (task) => {


                const university_id = task.university;
                const university_name = await universityNameById(university_id);


                return {
                    ...task,
                    // file: task.file ? `${req.protocol}://${req.get('host')}${task.file}` : null,

         file: task.file?.startsWith('http')
                        ? task.file
                        : `${req.protocol}://${req.get('host')}${task.file}`,

                    universityName: university_name[0]?.name || ''
                };
            })
        );
        res.status(200).json(data);

    } catch (error) {
        console.error("Error in getPaymentByEmail: ", error);
        res.status(500).json({ error: "Internal Server Error", details: error.message });
    }
}

export const deletePayment = async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await db.query('DELETE FROM payments WHERE id = ?', [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "payments not found" });
        }

        return res.status(200).json({ message: 'payments deleted successfully' });
    } catch (error) {
        console.log(`Internal server error: ${error}`);
        res.status(500).json({ message: 'Internal server error' });
    }
};

