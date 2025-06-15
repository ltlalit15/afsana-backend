import db from '../config/db.js';

export const getDashboardData = async (req, res) => {
    const {counselor_id} =req.params;
    try {
        const [totalLeads] = await db.query('SELECT COUNT(*) AS totalleads FROM leads WHERE counselor = ?', [counselor_id]);
        const [totalStudents] = await db.query('SELECT COUNT(*) AS totalstudents FROM students');
        const [totalCounselors] = await db.query('SELECT COUNT(*) AS totalcounselors FROM counselors');
        const [totalFollowUps] = await db.query('SELECT COUNT(*) AS totalFollowUps FROM follow_ups');
        const [totalTasks] = await db.query('SELECT COUNT(*) AS totalTasks FROM tasks WHERE counselor_id =?',[counselor_id]);
        const [totalInquiries] = await db.query('SELECT COUNT(*) AS totalInquiries FROM inquiries WHERE counselor_id =?',[counselor_id]);
        res.status(200).json({
            totalleads: totalLeads[0].totalleads,
            totalstudents: totalStudents[0].totalstudents,
            totalcounselors: totalCounselors[0].totalcounselors,
            totalFollowUps: totalFollowUps[0].totalFollowUps,
            totalTasks: totalTasks[0].totalTasks,
            totalInquiries: totalInquiries[0].totalInquiries
        });
    } catch (error) {
        console.error('Error fetching dashboard data:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};
export const getDashboardDataAdmin = async (req, res) => {
    
    try {
        const [totalLeads] = await db.query('SELECT COUNT(*) AS totalleads FROM leads ');
        const [totalStudents] = await db.query('SELECT COUNT(*) AS totalstudents FROM students');
        const [totalCounselors] = await db.query('SELECT COUNT(*) AS totalcounselors FROM counselors');
        const [totalFollowUps] = await db.query('SELECT COUNT(*) AS totalFollowUps FROM follow_ups');
        const [totalTasks] = await db.query('SELECT COUNT(*) AS totalTasks FROM tasks');
        const [totalInquiries] = await db.query('SELECT COUNT(*) AS totalInquiries FROM inquiries');
        const [totalUniversities] = await db.query('SELECT COUNT(*) AS totalUniversities FROM universities');

        res.status(200).json({
            totalleads: totalLeads[0].totalleads,
            totalstudents: totalStudents[0].totalstudents,
            totalcounselors: totalCounselors[0].totalcounselors,
            totalFollowUps: totalFollowUps[0].totalFollowUps,
            totalTasks: totalTasks[0].totalTasks,
            totalInquiries: totalInquiries[0].totalInquiries,
            totalUniversities: totalUniversities[0].totalUniversities,
        });
    } catch (error) {
        console.error('Error fetching dashboard data:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// export const getDashboardDataAdmin = async (req, res) => {
//     try {
//         const { startDate, endDate } = req.query;

//         // Default: No date filter
//         let dateFilter = '';
//         if (startDate && endDate) {
//             dateFilter = `WHERE created_at BETWEEN '${startDate}' AND '${endDate}'`;
//         }

//         const [totalLeads] = await db.query(`SELECT COUNT(*) AS totalleads FROM leads ${dateFilter}`);
//         const [totalStudents] = await db.query(`SELECT COUNT(*) AS totalstudents FROM students ${dateFilter}`);
//         const [totalCounselors] = await db.query(`SELECT COUNT(*) AS totalcounselors FROM counselors ${dateFilter}`);
//         const [totalFollowUps] = await db.query(`SELECT COUNT(*) AS totalFollowUps FROM follow_ups ${dateFilter}`);
//         const [totalTasks] = await db.query(`SELECT COUNT(*) AS totalTasks FROM tasks ${dateFilter}`);
//         const [totalInquiries] = await db.query(`SELECT COUNT(*) AS totalInquiries FROM inquiries ${dateFilter}`);
//         const [totalUniversities] = await db.query(`SELECT COUNT(*) AS totalUniversities FROM universities ${dateFilter}`);

//         res.status(200).json({
//             totalleads: totalLeads[0].totalleads,
//             totalstudents: totalStudents[0].totalstudents,
//             totalcounselors: totalCounselors[0].totalcounselors,
//             totalFollowUps: totalFollowUps[0].totalFollowUps,
//             totalTasks: totalTasks[0].totalTasks,
//             totalInquiries: totalInquiries[0].totalInquiries,
//             totalUniversities: totalUniversities[0].totalUniversities,
//         });
//     } catch (error) {
//         console.error('Error fetching dashboard data:', error);
//         res.status(500).json({ error: 'Internal Server Error' });
//     }
// };



export const getDashboardDataUniversity = async (req, res) => {
    const { university_id, studentId } = req.params;
  
    try {
      const query = `
        SELECT 
          Application_stage, 
          Interview,
          Visa_process
        FROM 
          StudentApplicationProcess 
        WHERE 
          student_id = ? 
          AND university_id = ?`;
          
      const [data] = await db.query(query, [studentId, university_id]);
  
      if (data.length === 0) {
        return res.status(404).json({ message: "No data found for the given student and university" });
      }
  
      res.status(200).json(data[0]);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  };
  
