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
  const { name, role, studentID, phone } = req.body;

  if (role == 'student') {
    // Use the hashed password in the INSERT query
    const sql = "INSERT INTO student (sid, sname, Phone_number) VALUES (?, ?, ?)";
    connection.query(sql, [studentID, name, phone], (error, results) => {
      if (error) {
        console.error('Error executing query:', error);
        res.status(500).json({ status: 'error', message: 'Registration failed' });
        return;
      }
      res.json({ status: 'success', message: 'Registration successful' });
    });
  }

  });


app.post('/login', (req, res) => {
  const { email, password } = req.body;
  const sql = "SELECT * FROM studentdetails WHERE email = ?";
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

    bcrypt.compare(password, user.password_hash, (err, result) => {
      if (err) {
        console.error('Error comparing passwords:', err);
        res.status(500).json({ status: 'error', message: 'Internal server error' });
        return;
      }

      if (result) {
        // Store user information in session
        req.session.user = { id: user.sid, name: user.name, email: user.email, role: user.role };
        // console.log('User set in session:', req.session.user); // Add this line to log the session user
   
        res.json({ status: 'success', message: 'Login successful', user: { name: user.name, email: user.email, role: user.role } });
        res.end(JSON.stringify({ message: 'Session started...' }));

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