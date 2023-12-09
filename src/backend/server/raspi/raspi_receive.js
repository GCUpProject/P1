const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const dbConfig = require("../dbconfig");
const router = express.Router();

const app = express();

app.use(bodyParser.json());

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// POST 요청 처리
app.post("/receive_data", (req, res) => {
  try {
    const data = req.body; // 받은 JSON 데이터를 파싱합니다.
    console.log("Received Data:", data);

    // 필요한 데이터 추출
    const { sensor_id, temp, humi, gas, fire } = data;

    // MySQL에 데이터 삽입
    const query = `INSERT INTO sensor_data (sensor_id, temp, humi, gas, fire) VALUES (?, ?, ?, ?, ?)`;
    connection.query(
      query,
      [sensor_id, temp, humi, gas, fire],
      (err, results) => {
        if (err) {
          console.error("MySQL에 데이터를 삽입하는 중 오류 발생:", err);
          throw err;
        }

        // 여기에 필요한 동작을 추가할 수 있습니다.

        console.log("데이터가 MySQL에 삽입됨:", results);

        const response = {
          status: "success",
          message: "데이터가 성공적으로 수신 및 저장됨",
        };
        res.status(200).json(response);
      }
    );
  } catch (error) {
    console.error("Error:", error);
    const response = {
      status: "error",
      message: "데이터 처리 및 저장에 실패",
    };
    res.status(500).json(response); // 500은 서버 내부 오류를 의미합니다.
  }
});

module.exports = router;
