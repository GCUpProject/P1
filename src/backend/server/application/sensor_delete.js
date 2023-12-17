const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const dbConfig = require('../dbconfig');

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// 센서 삭제
const sensorDelete = (req, res) => {
  const sensorId = req.params.sensor_id;

  if (!sensorId) {
    return res.status(400).json({ error: 'Missing sensor_id parameter' });
  }

  const deleteQuery = 'DELETE FROM sensor WHERE sensor_id = ?';
  connection.query(deleteQuery, [sensorId], (error, results) => {
    if (error) {
      console.error("MySQL에서 데이터를 삭제하는 중 오류 발생:", error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    console.log(results);
    return res.status(200).json({ message: 'Sensor deleted successfully' });
  });
};


router.delete("/sensor/:sensor_id", sensorDelete);

module.exports = router;
