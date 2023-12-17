const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const dbConfig = require('../dbconfig');

router.use(express.json());
router.use(express.urlencoded({ extended: false }));

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

function sensorAdd(req, res) {
  const { sensor_id, space_name, exit_status, extinguisher } = req.body;

  // Validate input data
  if (!sensor_id || !space_name || exit_status === undefined || extinguisher === undefined) {
    return res.status(400).json({ error: 'Invalid input data' });
  }

  // Check if sensor_id already exists
  const checkQuery = 'SELECT * FROM sensor WHERE sensor_id = ?';
  connection.query(checkQuery, [sensor_id], (checkError, checkResults) => {
    if (checkError) {
      console.error('Database error:', checkError);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (checkResults.length > 0) {
      // sensor_id already exists
      return res.status(409).json({ error: 'Sensor id already exists.' });
    }

    // Perform database query
    const insertQuery = 'INSERT INTO sensor (sensor_id, space_name, exit_status, extinguisher) VALUES (?, ?, ?, ?)';
    const values = [sensor_id, space_name, exit_status, extinguisher];

    connection.query(insertQuery, values, (insertError, insertResults) => {
      if (insertError) {
        console.error('Database error:', insertError);
        return res.status(500).json({ error: 'Internal server error' });
      }

      console.log(insertResults);
      return res.status(201).json({ message: 'Sensor registered successfully' });
      
    });
  });
}

router.post('/sensor', sensorAdd);

module.exports = router;
