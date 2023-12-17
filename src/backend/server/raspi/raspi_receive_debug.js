const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const dbconfig = require("../dbconfig");

const app = express();

const port = 60035;
app.use(express.urlencoded({ extended: false }));
app.use(bodyParser.json());

const router = express.Router();

// MySQL 연결 생성
const connection = mysql.createConnection(dbconfig);

// 연결 테스트
connection.connect((err) => {
  if (err) {
    console.error("Error connecting to MySQL:", err);
  } else {
    console.log("Connected to MySQL");
  }
});

// POST 요청 처리
const raspiReceive = (req, res) => {
  try {
    const data = req.body; // 받은 JSON 데이터를 파싱합니다.
    console.log("Received Data:", data);

    // 필요한 데이터 추출
    const { sensor_id, temperature, humidity, gas, fire } = data;

    // MySQL에 데이터 삽입
    const query = `INSERT INTO data (sensor_id, temp, humi, gas, fire) VALUES (?, ?, ?, ?, ?)`;
    connection.query(
      query,
      [sensor_id, temperature, humidity, gas, fire],
      (err, results) => {
        if (err) {
          console.error("Error inserting data into MySQL:", err);
          throw err;
        }

        // 여기에 필요한 동작을 추가할 수 있습니다.

        console.log("Data inserted into MySQL:", results);

        const response = {
          status: "success",
          message: "Data received and stored successfully",
        };
        res.status(200).json(response);
      }
    );
  } catch (error) {
    console.error("Error:", error);
    const response = {
      status: "error",
      message: "Failed to process and store the data",
    };
    res.status(500).json(response); // 500은 서버 내부 오류를 의미합니다.
  }
};

router.post("/receive_data", raspiReceive);

module.exports = router;
