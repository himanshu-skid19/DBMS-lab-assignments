import express from 'express';
import mysql from 'mysql2';
import bodyParser from 'body-parser';
import cors from 'cors';
import bcrypt from 'bcrypt';
import session from 'express-session';

const saltRounds = 10;


const app = express();
const port = 3001; // You can choose any port that's free



app.use(session({
  secret: 'your_secret_key', // This is a secret key used to sign the session ID cookie. Replace 'your_secret_key' with a real secret string.
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // If you're serving your site over HTTPS, set secure to true.
}));
app.use(cors({ origin: 'http://localhost:5173', credentials: true })); // Adjust the origin as per your React app's URL
app.use(bodyParser.json()); // Support json encoded bodies


// Create a connection to the database
const connection = mysql.createConnection({
  host: 'localhost', // or the IP address of your MySQL server
  user: 'root',
  password: '',
  database: 'exam_system'
});

// Connect to MySQL
connection.connect(err => {
  if (err) {
    return console.error('error: ' + err.message);
  }

  console.log('Connected to the MySQL server.');
});


app.post('/register', (req, res) => {
  const { name, email, password, role } = req.body;

  const saltRounds = 10;
  bcrypt.hash(password, saltRounds, (err, hashedPassword) => {
    if (err) {
      console.error('Error hashing password:', err);
      res.status(500).json({ status: 'error', message: 'Internal server error' });
      return;
    }

    // Use the hashed password in the INSERT query
    const sql = "INSERT INTO users (name, email, password_hash, role) VALUES (?, ?, ?, ?)";
    connection.query(sql, [name, email, hashedPassword, role], (error, results) => {
      if (error) {
        console.error('Error executing query:', error);
        res.status(500).json({ status: 'error', message: 'Registration failed' });
        return;
      }
      res.json({ status: 'success', message: 'Registration successful' });
    });
  });
});

app.post('/register2', (req, res) => {
  const { name, role, id, phone } = req.body;

  let sql;
  let params = [id, name, phone];

  if (role === 'student') {
    sql = "INSERT INTO student (sid, sname, Phone_number) VALUES (?, ?, ?)";
  } else if (role === 'evaluator') {
    sql = "INSERT INTO evaluators (evid, name, Phone) VALUES (?, ?, ?)";
  } else {
    // Handle unknown role
    res.status(400).json({ status: 'error', message: 'Invalid role specified' });
    return;
  }

  connection.query(sql, params, (error, results) => {
    if (error) {
      console.error('Error executing query:', error);
      res.status(500).json({ status: 'error', message: 'Registration failed' });
      return;
    }
    res.json({ status: 'success', message: 'Registration successful' });
  });
});

app.post('/login', (req, res) => {
  const { email, password, role } = req.body;
  
  // Choose the table based on the role
  const table = role === 'evaluator' ? 'evaluator_details' : 'studentdetails';
  
  // Assuming evaluator_details also has an email column
  const sql = `SELECT * FROM ${table} WHERE email = ?`;
  connection.query(sql, [email], (error, results) => {
    if (error) {
      console.error('Error executing query:', error);
      res.status(500).json({ status: 'error', message: 'Login failed' });
      return;
    }

    if (results.length === 0) {
      res.status(401).json({ status: 'error', message: 'Invalid email or password' });
      return;
    }

    const user = results[0];

    // Assuming both tables have a password_hash column
    bcrypt.compare(password, user.password_hash, (err, result) => {
      if (err) {
        console.error('Error comparing passwords:', err);
        res.status(500).json({ status: 'error', message: 'Internal server error' });
        return;
      }

      if (result) {
        // Set user information in session based on the role
        req.session.user = role === 'evaluator' 
          ? { id: user.evid, name: user.name, email: user.email, role }
          : { id: user.sid, name: user.name, email: user.email, role };

        res.json({ status: 'success', message: 'Login successful', user: { name: user.name, email: user.email, role } });
        // Removed the redundant res.end call, as res.json already ends the response.
      } else {
        res.status(401).json({ status: 'error', message: 'Invalid email or password' });
      }
    });
  });
});


app.post('/register-for-exam', (req, res) => {
  const { did } = req.body;
  console.log(req.session.user)
  // Ensure the user is logged in and has a session
  if (req.session.user && req.session.user.id) {
    const sql = "INSERT INTO exam_choices (sid, did) VALUES (?, ?)";
    connection.query(sql, [req.session.user.id, did], (error, results) => {
      if (error) {
        console.error('Error executing query:', error);
        res.status(500).json({ status: 'error', message: 'Registration failed' });
        return;
      }
      res.json({ status: 'success', message: 'Registration successful' });
    });
  } else {
    // If there is no user in session, send an error message
    res.status(401).json({ status: 'error', message: 'You must be logged in to register for an exam' });
  }
});

app.get('/get-user-info', (req, res) => {
  // Check if there's a user in the session]
  console.log(req.session.user)
  if (req.session.user) {
    res.json({ status: 'success', user: req.session.user });
  } else {
    // If no user is in session, return an error or empty user
    res.status(401).json({ status: 'error', message: 'No user logged in' });
  }
});

app.post('/exam-register', (req, res) => {
  console.log(req.session.user)
  const sql = "SELECT  * FROM exam_schedule_view";
  connection.query(sql, (error, results) => {
    if (error) {
      console.error('Error fetching exams:', error);
      res.status(500).json({ status: 'error', message: 'Failed to fetch exams' });
      return;
    }
    // console.log(results);
    res.json({ status: 'success', data: results });
  });
});

app.post('/register-exam', (req, res) => {
  const { examID, examName, fees, date, timeslot, venue, did } = req.body;

  // First, insert data into the Exam table
  const insertExamSql = 'INSERT INTO exam (eid, ename, fees) VALUES (?, ?, ?)';
  connection.query(insertExamSql, [examID, examName, fees], (err, result) => {
      if (err) {
          console.error('Error inserting into Exam table:', err);
          return res.status(500).json({ status: 'error', message: 'Failed to register exam' });
      }

      // Then, insert data into the dates table
      const insertDatesSql = 'INSERT INTO dates (did, Venue, Timeslot, Date) VALUES (?, ?, ?, ?)';
      connection.query(insertDatesSql, [did, venue, timeslot, date], (err, result) => {
          if (err) {
              console.error('Error inserting into dates table:', err);
              return res.status(500).json({ status: 'error', message: 'Failed to register exam' });
          }

          // Finally, insert eid and did into the exam_schedule table
          const insertExamScheduleSql = 'INSERT INTO exam_schedule (eid, did) VALUES (?, ?)';
          connection.query(insertExamScheduleSql, [examID, did], (err, result) => {
              if (err) {
                  console.error('Error inserting into exam_schedule table:', err);
                  return res.status(500).json({ status: 'error', message: 'Failed to complete exam registration' });
              }

              // If all inserts are successful, send a success response
              res.json({ status: 'success', message: 'Exam registered successfully' });
          });
      });
  });
});


app.post('/stud-schedule', (req, res) => {
  const {did : DateId, eid: ExamId} = req.body;
  console.log(DateId, ExamId);
  const sql = "SELECT  * FROM student_schedule where sid = ? ";
  connection.query(sql, [req.session.user.id] ,(error, results) => {
    if (error) {
      console.error('Error fetching exams:', error);
      res.status(500).json({ status: 'error', message: 'Failed to fetch exams' });
      return;
    }
    // console.log(results);
    res.json({ status: 'success', data: results });
  });
});

app.get('/students', (req, res) => {
  const sql = "SELECT DISTINCT sid, sname FROM student_result"; // Use DISTINCT to get unique student IDs and names

  connection.query(sql, (error, results) => {
    if (error) {
      console.error('Error fetching students:', error);
      res.status(500).json({ status: 'error', message: 'Failed to fetch students' });
      return;
    }

    const students = results.map(row => {
      return { id: row.sid, name: row.sname }; // Ensure to use 'sname' instead of 'name' if that is the column name
    });

    res.json(students); // Send the students array as a JSON response
  });
});

app.get('/exams-for-student', (req, res) => {
  const studentId = req.query.sid;
  if (!studentId) {
    res.status(400).json({ status: 'error', message: 'Student ID is required' });
    return;
  }

  // Adjust the following SQL to match your table's structure and columns.
  // This query assumes that 'eid' is the exam ID and 'ename' is the exam name.
  const sql = "SELECT DISTINCT eid, ename, did, date FROM student_result WHERE sid = ?";

  connection.query(sql, [studentId], (error, results) => {
    if (error) {
      console.error('Error fetching exams for student:', error);
      res.status(500).json({ status: 'error', message: 'Failed to fetch exams for student' });
      return;
    }

    // Create an array of exams with only the IDs and names
    const exams = results.map(row => ({
      id: row.eid,
      name: row.ename,
      did: row.did,
      date: row.date
    }));

    res.json(exams);
  });
});


app.get('/student-results', (req, res) => {
  const studentId = req.query.sid; // Get student ID from query string
  const examId = req.query.eid; // Get exam ID from query string
  const page = parseInt(req.query.page) || 1;
  const pageSize = parseInt(req.query.pageSize) || 10;
  const offset = (page - 1) * pageSize;

  let sql = "SELECT * FROM student_result WHERE 1=1";
  let params = [];

  // If a student ID is provided, add it to the WHERE clause
  if (studentId) {
    sql += " AND sid = ?";
    params.push(studentId);
  }

  // If an exam ID is provided, add it to the WHERE clause
  if (examId) {
    sql += " AND eid = ?";
    params.push(examId);
  }

  // Add limit and offset for pagination
  sql += " LIMIT ? OFFSET ?";
  params.push(pageSize, offset);

  connection.query(sql, params, (error, results) => {
    if (error) {
        console.error('Error fetching student results:', error);
        res.status(500).json({ status: 'error', message: 'Failed to fetch student results' });
        return;
    }
    res.json(results);
  });
});


app.post('/start-exam', (req, res) => {
  const {did : DateId, eid: ExamId} = req.body;
  console.log(DateId, ExamId);
  console.log("user info: ",req.session.user)

  if (!req.session.user){
    return res.status(401).json({ status: 'error', message: 'You must be logged in to start an exam' });
  }

  const examDetails = {
    did: DateId,
    eid: ExamId,
    startTime: Date.now(),
    duration: 60
  };

  req.session.questionDifficulty = 5;
  req.session.askedQuestions = [];

  req.session.exam = examDetails;
  res.json({ status: 'success', message: 'Exam started', examDetails });

});

app.get('/get-exam-questions', (req, res) => {
  if (!req.session.user || !req.session.exam) {
      return res.status(401).json({ status: 'error', message: 'User not logged in or exam not started' });
  }

  // Example validation: Check if the current time is within the exam duration
  const currentTime = Date.now();
  const examEndTime = new Date(req.session.exam.startTime).getTime() + req.session.exam.duration * 60000; // convert minutes to ms

  if (currentTime > examEndTime) {
      return res.status(403).json({ status: 'error', message: 'Exam time is over' });
  }

  if (!req.session.questionDifficulty) {
    req.session.questionDifficulty = 5; // Default start difficulty
  }

  let nextDifficulty = req.session.questionDifficulty;

  const previousQuestionAnsweredCorrectly = req.query.previousQuestionAnsweredCorrectly === 'true';
  nextDifficulty = previousQuestionAnsweredCorrectly ? Math.min(nextDifficulty + 1, 5) : Math.max(nextDifficulty - 1, 1);
  console.log(nextDifficulty);



  const askedQuestions = req.session.askedQuestions.length > 0 ? req.session.askedQuestions : ['Q000'];
  console.log(askedQuestions);
  const sql = "SELECT * FROM questions WHERE eid = ? AND difficulty = ? AND qid NOT IN (?) ORDER BY RAND() LIMIT 1";
  
  connection.query(sql, [req.session.exam.eid, nextDifficulty, askedQuestions], (error, results) => {
    if (error) {
      console.error('Error fetching questions:', error);
      res.status(500).json({ status: 'error', message: 'Failed to fetch questions' });
      return;
    }
    
    if (results.length > 0){
      const nextQuestion = results[0];
      askedQuestions.push(nextQuestion.qid);
      req.session.askedQuestions = askedQuestions;
      req.session.questionDifficulty = nextDifficulty;
      res.json({ status: 'success', data: nextQuestion });
    }
    else{
      res.status(404).json({ status: 'error', message: 'No questions available' });
    }

  });

});

app.post('/save-responses', (req, res) => {
  if (!req.session.user){
    return res.status(401).json({ status: 'error', message: 'You must be logged in to save responses' });
  }

  const { eid, sid, did, responses } = req.body;
  const responseEntries = responses.map(response => [
    eid,
    req.session.user.id,
    did,
    response.qid,
    JSON.stringify(response)
  ]);

  const sql = "INSERT INTO savedanswers (eid, sid, did, qid, response) VALUES ?";
  connection.query(sql, [responseEntries], (error, results) => {
    if (error) {
      console.error('Error saving responses:', error);
      res.status(500).json({ status: 'error', message: 'Failed to save responses' });
      return;
    }
    res.json({ status: 'success', message: 'Responses saved' });
  });
});


app.get('/exam-details', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ status: 'error', message: 'You must be logged in to view exam details' });
  }

  const { eid, did } = req.query;
  let sql = `
    SELECT 
      e.eid,
      e.ename AS exam_name,
      SUM(JSON_EXTRACT(sa.response, '$.iscorrect') = true) AS correct_answers,
      SUM(JSON_EXTRACT(sa.response, '$.iscorrect') = false) AS incorrect_answers,
      AVG(CASE WHEN JSON_EXTRACT(sa.response, '$.iscorrect') = true THEN JSON_EXTRACT(sa.response, '$.timetaken') END) AS average_time_correct,
      AVG(CASE WHEN JSON_EXTRACT(sa.response, '$.iscorrect') = false THEN JSON_EXTRACT(sa.response, '$.timetaken') END) AS average_time_incorrect
    FROM savedanswers sa
    JOIN exam e ON sa.eid = e.eid
    WHERE sa.eid = ?`;

  // Adjust the SQL query and parameters based on the presence of `did`
  let params = [eid]; // Always include `eid` in the parameters array
  if (did) {
    sql += " AND sa.did = ?";
    params.push(did); // Add `did` to the parameters array if it's present
  }

  sql += " GROUP BY sa.eid;";

  connection.query(sql, params, (error, results) => {
    if (error) {
      console.error('Error fetching exam details:', error);
      res.status(500).json({ status: 'error', message: 'Failed to fetch exam details' });
      return;
    }
    // Assuming results are correctly fetched and structured
    console.log("Fetched shit is", results[0]);
    res.json({ status: 'success', data: results[0] || {} });
  });
});

app.get('/exam-analytics', (req, res) => {
  const { sid, eid } = req.query;

  if (!sid || !eid) {
    return res.status(400).json({ status: 'error', message: 'Student ID and Exam ID are required' });
  }

  const sql = `
    SELECT 
        sa.eid,
        sa.did,
        e.ename AS exam_name, 
        COUNT(sa.qid) AS total_questions,
        SUM(CASE WHEN JSON_EXTRACT(sa.response, '$.iscorrect') = true THEN 1 ELSE 0 END) AS correct_answers,
        AVG(JSON_EXTRACT(sa.response, '$.timetaken')) AS average_time_taken,
        AVG(JSON_EXTRACT(sa.response, '$.difficulty')) AS average_difficulty
    FROM 
      savedanswers sa
      JOIN exam e ON sa.eid = e.eid
    WHERE 
      sa.sid = ? AND sa.eid = ?
    GROUP BY 
      sa.eid, sa.did;
  `;

  connection.query(sql, [sid, eid], (error, results) => {
    if (error) {
      console.error('Error fetching exam analytics:', error);
      res.status(500).json({ status: 'error', message: 'Failed to fetch exam analytics' });
      return;
    }

    res.json({ status: 'success', data: results[0] || {} }); // Assuming there's only one result per sid-eid pair
  });
});



app.get('/analytics', (req, res) => {
  if (!req.session.user){
    return res.status(401).json({ status: 'error', message: 'You must be logged in to view analytics' });
  }

  const userId = req.session.user.id;

  const sql = `
    SELECT 
        sa.eid,
        sa.did,
        e.ename AS exam_name, 
        COUNT(sa.qid) AS total_questions,
        SUM(CASE WHEN JSON_EXTRACT(sa.response, '$.iscorrect') = true THEN 1 ELSE 0 END) AS correct_answers,
        AVG(JSON_EXTRACT(sa.response, '$.timetaken')) AS average_time_taken,
        AVG(JSON_EXTRACT(sa.response, '$.difficulty')) AS average_difficulty
    FROM 
      savedanswers sa
      JOIN exam e ON sa.eid = e.eid
    WHERE 
      sa.sid = ?
    GROUP BY 
      sa.eid;
    `;

    connection.query(sql, [userId], (error, results) => {
      if (error){
        console.error('Error fetching analytics:', error);
        res.status(500).json({ status: 'error', message: 'Failed to fetch analytics' });
        return;
      }
      console.log(results);
      res.json({ status: 'success', data: results });
    });

});
app.post('/end-exam', (req, res) => {
  if (req.session.exam) {
      delete req.session.exam; // Remove exam details from session
      return res.json({ status: 'success', message: 'Exam ended' });
  }
  res.status(400).json({ status: 'error', message: 'No exam to end' });
});

app.post('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      res.status(500).json({ status: 'error', message: 'Could not log out, please try again' });
    } else {
      res.clearCookie('connect.sid'); // The name 'connect.sid' is the default session ID cookie name, adjust if needed.
      res.json({ status: 'success', message: 'Logout successful' });
    }
  });
});
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});