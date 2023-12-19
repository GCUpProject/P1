const express = require("express");
const router = express.Router();
const mysql = require("mysql");
const dbConfig = require("../dbconfig");

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// 전체 센서 조회
const sensorIdRead = (req, res) => {
  const query = "SELECT sensor_id FROM sensor ORDER BY sensor_id";
  connection.query(query, (error, results) => {
    if (error) {
      console.error("Database error:", error);
      return res.status(500).json({ error: "Internal server error" });
    }

    console.log(results);
    return res.status(200).json(results);
  });
};

router.get("/sensor_id", sensorIdRead);

module.exports = router;
