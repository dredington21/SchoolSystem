const express = require('express');
const router = express.Router();
const db = require('../db'); // Adjust the path to your database connection file

// Create course (POST)
router.post('/courses', (req, res) => {
  const { course_prefix, course_number, department_id, credits, semesters } = req.body;
  const query = 'INSERT INTO courses (course_prefix, course_number, department_id, credits, semesters) VALUES (?, ?, ?, ?, ?)';
  db.query(query, [course_prefix, course_number, department_id, credits, semesters], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error', details: err.message });
    }
    res.status(201).json({ message: 'Course added successfully' });
  });
});

// Get course by ID (GET)
router.get('/courses/:course_id', (req, res) => {
  const query = 'SELECT * FROM courses WHERE course_id = ?';
  const courseId = req.params.course_id;

  db.query(query, [courseId], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Failed to fetch course', details: err.message });
    }
    if (results.length === 0) {
      return res.status(404).json({ error: 'Course not found' });
    }
    res.json(results[0]);
  });
});

// Get all courses (GET)
router.get('/courses', (req, res) => {
  const query = 'SELECT * FROM courses';
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Failed to fetch courses', details: err.message });
    }
    res.json(results);
  });
});

// Update course (PUT)
router.put('/courses/:course_id/:course_prefix/:course_number/:credits/:semesters', (req, res) => {
  const { course_id, course_prefix, course_number, credits, semesters } = req.params;
  const query = 'UPDATE courses SET course_prefix = ?, course_number = ?, credits = ?, semesters = ? WHERE course_id = ?';
  
  db.query(query, [course_prefix, course_number, credits, semesters, course_id], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error', details: err.message });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ error: 'Course not found' });
    }
    res.json({ message: 'Course updated successfully', course_id });
  });
});

// Delete course (DELETE)
router.delete('/courses/:course_id', (req, res) => {
  const { course_id } = req.params;
  const query = 'DELETE FROM courses WHERE course_id = ?';
  
  db.query(query, [course_id], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error', details: err.message });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ error: 'Course not found' });
    }
    res.json({ message: 'Course deleted successfully' });
  });
});

module.exports = router;
