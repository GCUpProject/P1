const express = require("express");
const router = express.Router();
const mysql = require("mysql");
const dbConfig = require("../dbconfig");

const app = express();

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// GET 요청 처리 (센서 데이터 조회)
app.get("/sensorData/:sensor_id", (req, res) => {
  try {
    const sensorId = req.params.sensor_id;

    // MySQL에서 해당 센서의 데이터 조회
    const query = `SELECT * FROM sensor_data WHERE sensor_id = ?`;
    connection.query(query, [sensorId], (err, results) => {
      if (err) {
        console.error("MySQL에서 데이터를 조회하는 중 오류 발생:", err);
        throw err;
      }

      // 조회된 데이터를 클라이언트에 응답
      const responseData = {
        status: "success",
        data: results,
      };
      res.status(200).json(responseData);
    });
  } catch (error) {
    console.error("오류:", error);
    const response = {
      status: "error",
      message: "센서 데이터 검색 실패",
    };
    res.status(500).json(response);
  }
});

module.exports = router;
