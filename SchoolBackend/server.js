const express = require('express');
const mysql = require('mysql2');

const app = express();
const port = 3000;
const cors = require('cors');

app.use(cors());
app.use(express.json());

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'School'
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err);
    return;
  }
  console.log('Connected to the MySQL database.');
});

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;

  // Query the database to find the user by username (or ID)
  const query = 'SELECT * FROM users WHERE id = ? AND password = ?';
  db.query(query, [username, password], (err, results) => {
    if (err) {
      console.error('Error querying the database:', err);
      return res.status(500).send('Server error');
    }

    if (results.length === 0) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }

    // Assume user record contains the role (e.g., staff, advisor, student, instructor)
    const user = results[0];
    res.json({
      success: true,
      role: user.role, // or any other role field
      studentId: user.id, // Include the studentId (or id)
    });
  });
});

// Define the enrollments/current route directly
app.get('/api/enrollments/current/:student_id', (req, res) => {
  console.log('Request received');
  const { student_id } = req.params;
  console.log('Student ID:', student_id);
  const query = `
    SELECT * FROM enrollments 
    WHERE student_id = ? AND year_taken = 2024 
    AND semester = 'F';
  `;
  db.query(query, [student_id], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).send(err);
    }
    console.log('Query results:', results);
    res.json(results);
  });
});

app.get('/api/enrollments/past/:student_id', (req, res) => {
  console.log('Request received');
  const { student_id } = req.params;
  console.log('Student ID:', student_id);

  const query = `
    SELECT * 
    FROM enrollments 
    WHERE 
      student_id = ? 
      AND (
        (year_taken = 2024 AND semester IN ('S', 'U')) 
        OR (year_taken < 2024)
      );
  `;
  db.query(query, [student_id], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).send(err);
    }
    console.log('Query results:', results);
    res.json(results);
  });
});

app.post('/api/enrollments/add/:student_id/:course_id', (req, res) => {
  console.log('Add enrollment request received');
  
  const { student_id, course_id } = req.params; // Expecting these values in the request body.


  const query = `
    INSERT INTO enrollments (student_id, course_id, semester, grade, year_taken)
    VALUES (?, ?, 'F', NULL, 2024);
  `;

  db.query(query, [student_id, course_id], (err, result) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).send(err);
    }
    console.log('New enrollment added:', result);
    res.status(201).json({ message: 'Enrollment added successfully', enrollment_id: result.insertId });
  });
});

app.delete('/api/enrollments/drop/:student_id/:course_id', (req, res) => {
  console.log('Drop enrollment request received');
  
  const { student_id, course_id } = req.params; // Expecting these values in the request params.

  const query = `
    DELETE FROM enrollments 
    WHERE student_id = ? AND course_id = ?;
  `;

  db.query(query, [student_id, course_id], (err, result) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).send(err);
    }

    // Check if a row was actually deleted
    if (result.affectedRows === 0) {
      console.log('No enrollment found to drop');
      return res.status(404).json({ message: 'Enrollment not found for the given student and course' });
    }

    console.log('Enrollment dropped:', result);
    res.status(200).json({ message: 'Enrollment dropped successfully' });
  });
});

// Route to get current courses taught by an instructor
app.get('/api/instructors/:instructor_id/current-courses', (req, res) => {
  const { instructor_id } = req.params;

  const query = `
    SELECT ci.course_id, c.course_prefix, c.course_number, c.credits, ci.semester, e.year_taken
    FROM classinfo ci
    JOIN courses c ON ci.course_id = c.course_id
    JOIN enrollments e ON ci.course_id = e.course_id
    WHERE ci.instructor_id = ?
      AND e.year_taken = YEAR(CURDATE()) -- Assuming current year
      AND e.semester NOT IN ('S', 'U');  -- Adjusted logic for "current" semester
  `;

  db.query(query, [instructor_id], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

// Route to get past courses taught by an instructor
app.get('/api/instructors/:instructor_id/past-courses', (req, res) => {
  const { instructor_id } = req.params;

  const query = `
    SELECT ci.course_id, c.course_prefix, c.course_number, c.credits, ci.semester, e.year_taken
    FROM classinfo ci
    JOIN courses c ON ci.course_id = c.course_id
    JOIN enrollments e ON ci.course_id = e.course_id
    WHERE ci.instructor_id = ?
      AND (
        (e.year_taken < YEAR(CURDATE())) OR
        (e.year_taken = YEAR(CURDATE()) AND e.semester IN ('S', 'U')) -- Past semester logic
      );
  `;

  db.query(query, [instructor_id], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

// Route to get the count of students by major for courses taught by an instructor
app.get('/api/instructors/:instructor_id/student-counts', (req, res) => {
  const { instructor_id } = req.params;

  const query = `
    SELECT s.department_id AS major, COUNT(*) AS count
    FROM classinfo ci
    JOIN enrollments e ON ci.course_id = e.course_id
    JOIN students s ON e.student_id = s.student_id
    WHERE ci.instructor_id = ?
    GROUP BY s.department_id;
  `;

  db.query(query, [instructor_id], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).send(err);
    }
    res.json(results);
  });
});



app.get('/', (req, res) => {
  res.send('Hello World!');
});

const studentsRoutes = require('./routes/students');
app.use('/api/students', studentsRoutes);


const usersRoutes = require('./routes/users');
app.use('/api', usersRoutes);

const staffsRoutes = require('./routes/staffs');
app.use('/api', staffsRoutes);

const logsRoutes = require('./routes/logs');
app.use('/api', logsRoutes);

const instructorsRoutes = require('./routes/instructors');
app.use('/api', instructorsRoutes);


const enrollmentsRoutes = require('./routes/enrollments');
app.use('/api', enrollmentsRoutes);

const departmentsRoutes = require('./routes/departments');
app.use('/api', departmentsRoutes);

const coursesRoutes = require('./routes/courses');
app.use('/api', coursesRoutes);


const classinfoRoutes = require('./routes/classinfo');
app.use('/api', classinfoRoutes);

const advisorsRoutes = require('./routes/advisors');
app.use('/api', advisorsRoutes);

const summariesRoutes = require('./routes/summaries');
app.use('/api', summariesRoutes);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});