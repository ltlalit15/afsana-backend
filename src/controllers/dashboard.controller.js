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
      counselorsFilter.push(getDateFilter('c.'));
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
      counselorsFilter.push(`c.id = '${counselor_id}'`);
    }
    if (leadStatus) {
      inquiryFilters.push(`lead_status = '${leadStatus}'`);
    }
    if (intake) {

      inquiryFilters.push(`intake = '${intake}'`);
    }
    const buildWhereClause = (filters) => filters.length ? `WHERE ${filters.join(' AND ')}` : '';
    const [totalLeads] = await db.query(`SELECT COUNT(*) AS totalleads FROM inquiries WHERE lead_status = 'Converted to Lead' ${buildWhereClause(leadFilters)}`);
    const [totalStudents] = await db.query(`SELECT COUNT(*) AS totalstudents FROM students ${buildWhereClause(commonFilters)}`);
    // const [totalCounselors] = await db.query(`SELECT COUNT(*) AS totalcounselors FROM counselors ${buildWhereClause(counselorsFilter)}`);

    const [totalCounselors] = await db.query(`
  SELECT COUNT(*) AS totalcounselors 
  FROM counselors c 
  JOIN users u ON c.id = u.counselor_id 
  ${buildWhereClause(counselorsFilter)}
`);
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

    const [weeklyInquiries] = await db.query(`
  SELECT 
  d.day,
  COUNT(i.id) AS total_inquiries
FROM (
  SELECT 'Monday' AS day UNION
  SELECT 'Tuesday' UNION
  SELECT 'Wednesday' UNION
  SELECT 'Thursday' UNION
  SELECT 'Friday' UNION
  SELECT 'Saturday' UNION
  SELECT 'Sunday'
) AS d
LEFT JOIN inquiries i ON DAYNAME(i.created_at) = d.day 
  AND YEARWEEK(i.created_at, 1) = YEARWEEK(CURDATE(), 1)
GROUP BY d.day
ORDER BY FIELD(d.day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

`);

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
      weekly_inquiries_by_day: weeklyInquiries


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

// Counslor Dashboard

export const getCounselorDashboardData = async (req, res) => {
  try {
    const {
      startDate,
      endDate,
      country,
      intake,
      leadStatus,
      counselor_id
    } = req.query;
    const getDateFilter = (alias = '') =>
      startDate && endDate
        ? `${alias}created_at BETWEEN '${startDate} 00:00:00' AND '${endDate} 23:59:59'`
        : '';
    const filters = [];
    if (startDate && endDate) filters.push(getDateFilter());
    if (country) filters.push(`country = '${country}'`);
    if (intake) filters.push(`intake = '${intake}'`);
    if (leadStatus) filters.push(`lead_status = '${leadStatus}'`);
    if (counselor_id) filters.push(`counselor_id = '${counselor_id}'`);
    const whereClause = filters.length ? `WHERE ${filters.join(' AND ')}` : '';
    const counselorWhere = `WHERE counselor_id = '${counselor_id}'`;



    const [leads] = await db.query(`SELECT COUNT(*) AS totalleads FROM inquiries WHERE counselor_id = ?`, [counselor_id]);
    const [students] = await db.query(`SELECT COUNT(*) AS totalstudents FROM students WHERE counselor_id = ?`, [counselor_id]);
    const [universities] = await db.query(`SELECT  COUNT(*) AS totalUniversities FROM counselors WHERE id = ?`, [counselor_id]);
    const [tasks] = await db.query(`SELECT COUNT(*) AS totalTasks FROM tasks WHERE counselor_id = ?`, [counselor_id]);
    // const [followups] = await db.query(`SELECT COUNT(*) AS totalFollowUps FROM follow_ups WHERE counselor_id = ?`, [counselor_id]);
    // Conversion Funnel
    const [inquiries] = await db.query(`SELECT COUNT(*) AS total FROM inquiries WHERE counselor_id = ?`, [counselor_id]);
    const [applications] = await db.query(`SELECT COUNT(*) AS total FROM studentapplicationprocess WHERE counselor_id =?`, [counselor_id]);
    // Efficiency Calculation
    const followUpsDue = inquiries[0].total;
    // const followUpsDone = followups[0].totalFollowUps;
    const leadsCount = leads[0].totalleads;
    const studentsCount = students[0].totalstudents;
    // const followUpEfficiency = followUpsDue > 0 ? ((followUpsDone / followUpsDue) * 100).toFixed(2) : "0.00";
    const conversionRate = leadsCount > 0 ? ((studentsCount / leadsCount) * 100).toFixed(2) : "0.00";
    // Follow-up Gaps
    const [gapLeads] = await db.query(`
      SELECT COUNT(*) AS gapCount 
      FROM leads 
      WHERE counselor = ? AND DATEDIFF(NOW(), follow_up_date) > 7
    `, [counselor_id]);
    // Performance Tips
    const [uncontactedLeads] = await db.query(`
      SELECT COUNT(*) AS uncontacted 
      FROM leads 
      WHERE counselor = ? AND DATEDIFF(NOW(), follow_up_date) > 10
    `, [counselor_id]);
    // Recent Leads
    const [recentLeads] = await db.query(`
      SELECT full_name AS name, country, intake, lead_status AS status, follow_up_date AS last_follow_up 
      FROM inquiries 
      WHERE counselor_id = ? 
      ORDER BY created_at DESC 
      LIMIT 5
    `, [counselor_id]);
    // Student Application List
    // const [studentApps] = await db.query(`
    //   SELECT s.full_name AS name, u.name AS university, a.Application_stage AS stage, a.created_at AS assigned_date 
    //   FROM students s
    //   JOIN universities u ON s.university_id = u.id
    //   JOIN studentapplicationprocess a ON s.id = a.student_id
    //   WHERE s.counselor_id = ?
    //   ORDER BY a.created_at DESC 
    //   LIMIT 5
    // `, [counselor_id]);
    const [studentApps] = await db.query(`
  SELECT 
    s.full_name AS name, 
    u.name AS university, 
    a.Application_stage AS stage, 
    a.created_at AS assigned_date 
  FROM studentapplicationprocess a
  JOIN students s ON a.student_id = s.id
  JOIN universities u ON a.university_id = u.id
  WHERE a.counselor_id = ?
  ORDER BY a.created_at DESC 
  LIMIT 5
`, [counselor_id]);
    // Follow-up Table
    // const [followUpList] = await db.query(`
    //   SELECT type, date, remarks, status 
    //   FROM follow_ups 
    //   WHERE counselor_id = ? 
    //   ORDER BY date DESC 
    //   LIMIT 5
    // `, [counselor_id]);
    res.status(200).json({
      kpi: {
        totalLeads: leads[0].totalleads,
        totalStudents: students[0].totalstudents,
        totalUniversities: universities[0].totalUniversities,
        totalTasks: tasks[0].totalTasks,
        // totalFollowUps: followups[0].totalFollowUps,
        // followUpEfficiency: `${followUpEfficiency}%`,
        conversionRate: `${conversionRate}%`,
        inquiries: inquiries[0].total,
        applications: applications[0].total
      },
      // conversionFunnel: {
      //   inquiries: inquiries[0].total,
      //   leads: leadsCount,
      //   students: studentsCount,
      //   applications: applications[0].total
      // },
      // followUpGaps: `${gapLeads[0].gapCount} leads not followed up in 7+ days`,
      // performanceTips: `${uncontactedLeads[0].uncontacted} leads not contacted in 10 days`,
      recentLeads,
      studentApplications: studentApps,
      // followUpTable: followUpList
    });

  } catch (error) {
    console.error("Counselor Dashboard Error:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};



export const sataffdashboard = async (req, res) => {
  try {
    // Total converted leads
    const [totalLeads] = await db.query(
      `SELECT COUNT(*) AS totalleads FROM inquiries WHERE lead_status = 'Converted to Lead'`
    );
    // Total inquiries
    const [totalInquiries] = await db.query(
      `SELECT COUNT(*) AS totalinquiries FROM inquiries`
    );
    // You can add more queries here if needed, like ordersYes, ordersNo, latestOrders
    res.status(200).json({
      success: true,
      data: {
        total_leads: totalLeads[0].totalleads,
        total_inquiries: totalInquiries[0].totalinquiries,
        chart_data: [
          { label: 'Leads', value: totalLeads[0].totalleads },
          { label: 'Inquiries', value: totalInquiries[0].totalinquiries }
        ]
        // Add additional keys here if you include other queries above
      },
    });
  } catch (error) {
    console.error("❌ Dashboard summary error:", error);
    res.status(500).json({ success: false, message: "Internal Server Error" });
  }
};






