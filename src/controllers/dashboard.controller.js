import db from '../config/db.js';

export const getDashboardData = async (req, res) => {
  const { counselor_id } = req.params;
  try {
    const [totalLeads] = await db.query('SELECT COUNT(*) AS totalleads FROM leads WHERE counselor = ?', [counselor_id]);
    const [totalStudents] = await db.query('SELECT COUNT(*) AS totalstudents FROM students');
    const [totalCounselors] = await db.query('SELECT COUNT(*) AS totalcounselors FROM counselors');
    const [totalFollowUps] = await db.query('SELECT COUNT(*) AS totalFollowUps FROM follow_ups');
    const [totalTasks] = await db.query('SELECT COUNT(*) AS totalTasks FROM tasks WHERE counselor_id =?', [counselor_id]);
    const [totalInquiries] = await db.query('SELECT COUNT(*) AS totalInquiries FROM inquiries WHERE counselor_id =?', [counselor_id]);
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
// export const getDashboardDataAdmin = async (req, res) => {

//     try {
//         const [totalLeads] = await db.query('SELECT COUNT(*) AS totalleads FROM leads ');
//         const [totalStudents] = await db.query('SELECT COUNT(*) AS totalstudents FROM students');
//         const [totalCounselors] = await db.query('SELECT COUNT(*) AS totalcounselors FROM counselors');
//         const [totalFollowUps] = await db.query('SELECT COUNT(*) AS totalFollowUps FROM follow_ups');
//         const [totalTasks] = await db.query('SELECT COUNT(*) AS totalTasks FROM tasks');
//         const [totalInquiries] = await db.query('SELECT COUNT(*) AS totalInquiries FROM inquiries');
//         const [totalUniversities] = await db.query('SELECT COUNT(*) AS totalUniversities FROM universities');

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

export const getDashboardDataAdmin = async (req, res) => {
  try {
    const { startDate, endDate, country, source, counselor_id, leadStatus, intake } = req.query;

    // Common date filter
    const getDateFilter = (alias = '') =>
      startDate && endDate
        ? `${alias}created_at BETWEEN '${startDate} 00:00:00' AND '${endDate} 23:59:59'`
        : '';

    // Table-specific filters
    const leadFilters = [];
    const inquiryFilters = [];
    const counselorsFilter = [];
    const commonFilters = [];

    if (startDate && endDate) {
      leadFilters.push(getDateFilter());
      inquiryFilters.push(getDateFilter());
      commonFilters.push(getDateFilter());
    }

    if (country) {
      leadFilters.push(`preferred_countries = '${country}'`);
      inquiryFilters.push(`country = '${country}'`);
    }

    if (source) {
      leadFilters.push(`source = '${source}'`);
      inquiryFilters.push(`source = '${source}'`);
    }

    if (counselor_id) {

      leadFilters.push(`counselor = '${counselor_id}'`);
      inquiryFilters.push(`counselor_id = '${counselor_id}'`);
      counselorsFilter.push(`id = '${counselor_id}'`);
    }

    if (leadStatus) {
      inquiryFilters.push(`lead_status = '${leadStatus}'`);
    }

    if (intake) {

      inquiryFilters.push(`intake = '${intake}'`);

    }


    const buildWhereClause = (filters) => filters.length ? `WHERE ${filters.join(' AND ')}` : '';

    const [totalLeads] = await db.query(`SELECT COUNT(*) AS totalleads FROM leads ${buildWhereClause(leadFilters)}`);
    const [totalStudents] = await db.query(`SELECT COUNT(*) AS totalstudents FROM students ${buildWhereClause(commonFilters)}`);
    const [totalCounselors] = await db.query(`SELECT COUNT(*) AS totalcounselors FROM counselors ${buildWhereClause(counselorsFilter)}`);
    const [totalFollowUps] = await db.query(`SELECT COUNT(*) AS totalFollowUps FROM follow_ups ${buildWhereClause(commonFilters)}`);
    const [totalTasks] = await db.query(`SELECT COUNT(*) AS totalTasks FROM tasks ${buildWhereClause(commonFilters)}`);
    const [totalInquiries] = await db.query(`SELECT COUNT(*) AS totalInquiries FROM inquiries ${buildWhereClause(inquiryFilters)}`);
    const [totalUniversities] = await db.query(`SELECT COUNT(*) AS totalUniversities FROM universities ${buildWhereClause(commonFilters)}`);

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

export const getDashboardInfo = async (req, res) => {
  try {
    const [result] = await db.query(`
      SELECT
        -- This Month
        SUM(CASE WHEN MONTH(created_at) = MONTH(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE()) THEN 1 ELSE 0 END) AS this_month_total,
        SUM(CASE WHEN MONTH(created_at) = MONTH(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE()) AND lead_status = 'Converted to Lead' THEN 1 ELSE 0 END) AS this_month_converted,

        -- Last Month
        SUM(CASE WHEN MONTH(created_at) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(created_at) = YEAR(CURDATE() - INTERVAL 1 MONTH) THEN 1 ELSE 0 END) AS last_month_total,
        SUM(CASE WHEN MONTH(created_at) = MONTH(CURDATE() - INTERVAL 1 MONTH) AND YEAR(created_at) = YEAR(CURDATE() - INTERVAL 1 MONTH) AND lead_status = 'Converted to Lead' THEN 1 ELSE 0 END) AS last_month_converted
      FROM inquiries
    `);

    const {
      this_month_total,
      this_month_converted,
      last_month_total,
      last_month_converted,
    } = result[0];

    const thisMonthRate = this_month_total > 0 ? (this_month_converted / this_month_total) * 100 : 0;
    const lastMonthRate = last_month_total > 0 ? (last_month_converted / last_month_total) * 100 : 0;

    const growthRate = thisMonthRate - lastMonthRate;

// const [weeklyInquiries] = await db.query(`
//   SELECT 
//     DAYNAME(created_at) AS day,
//     COUNT(*) AS total_inquiries
//   FROM inquiries
//   WHERE YEARWEEK(created_at, 1) = YEARWEEK(CURDATE(), 1)
//   GROUP BY DAYNAME(created_at)
//   ORDER BY FIELD(DAYNAME(created_at), 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
// `);



    const [topCounselors] = await db.query(`
  SELECT
    IFNULL(c.counselor_id, i.counselor_id) AS counselor_id,
    IFNULL(c.full_name, 'Admin') AS full_name,
    COUNT(*) AS converted_leads
  FROM inquiries i
  LEFT JOIN users c ON i.counselor_id = c.counselor_id
  WHERE i.lead_status = 'Converted to Lead'
  GROUP BY counselor_id, full_name
  ORDER BY converted_leads DESC
  LIMIT 3
`);

    const [countryWiseConvertedLeads] = await db.query(`
      SELECT
        country,
        COUNT(*) AS inquiries
      FROM inquiries
      GROUP BY country
      ORDER BY inquiries DESC
    `);


    const [leadCount] = await db.query('SELECT COUNT(*) AS totalleads FROM leads')
    const [studentCount] = await db.query("SELECT COUNT(*) AS totalleads FROM students WHERE role = 'student'");
    const [inquiries] = await db.query('SELECT COUNT(*) AS totalleads FROM inquiries')
    const [application] = await db.query('SELECT COUNT(*) AS application FROM studentapplicationprocess')

    res.status(200).json({
      this_month_conversion_rate: `${thisMonthRate.toFixed(2)}%`,
      last_month_conversion_rate: `${lastMonthRate.toFixed(2)}%`,
      growth_rate: `${growthRate >= 0 ? '+' : ''}${growthRate.toFixed(2)}%`,
      top_counselors: topCounselors,
      country_wise_converted_leads: countryWiseConvertedLeads,
      conversion_funnel: {
        leadCount: leadCount[0].totalleads,
        inquiries: inquiries[0].totalleads,
        application: application[0].application,
        studentCount: studentCount[0].totalleads
      },
        // weekly_inquiries_by_day: weeklyInquiries 


    });

  } catch (error) {
    console.error("Dashboard Info Error:", error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};


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

