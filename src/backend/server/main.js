const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const dbConfig = require("./dbconfig");

const sensorDataRead = require("application/sensor_data_read");
const adminAuth = require("applicaion/admin_auth");
const raspiReceive = require("raspi/raspi_receive");

const app = express();
const port = 60035;

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// 연결 테스트
connection.connect((err) => {
  if (err) {
    console.error("Error connecting to MySQL:", err);
  } else {
    console.log("Connected to MySQL");
  }
});

// ------- 애플리케이션 API ------
// 센서 데이터 조회 라우팅
app.use("/sensorData", sensorDataRead);
app.use("/admin_auth", adminAuth);

// ------ 라즈베리파이 API ------
app.use("/receive", raspiReceive);

// 서버 종료 시 MySQL 연결 종료
process.on("SIGINT", () => {
  connection.end();
  process.exit();
});

// 서버 시작
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
