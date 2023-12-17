const express = require("express");
const mysql = require("mysql");
const dbConfig = require("./dbconfig");

const sensorDataRead = require("./application/sensor_data_read");
const sensorDataReadById = require("./application/sensor_data_read");
const sensorAdd = require("./application/sensor_add");
const sensorRead = require("./application/sensor_read");
// const sensorReadBySpaceId = require("./application/sensor_read");
const sensorDelete = require("./application/sensor_delete");

const spaceRead = require("./application/space_read");

const adminAuth = require("./application/admin_auth");
const uploadFloorPlan = require("./application/upload_floor_plan");
const raspiReceive = require("./raspi/raspi_receive");

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
app.get("/sensor_data", sensorDataRead);
app.get("/sensor_data/:sensor_id", sensorDataReadById);

// 센서 정보 등록 라우팅
app.post("/sensor", sensorAdd);

// 센서 정보 조회 라우팅
app.get("/sensor", sensorRead);
// app.get("/sensor/:space_id", sensorReadBySpaceId);

// 센서 삭제 라우팅
app.delete("/sensor/:sensor_id", sensorDelete);

// 방 정보 조회 라우팅
app.get("/space", spaceRead);

// 관리자 인증 라우팅
app.post("/admin_auth", adminAuth);

// 도면도 이미지 업로드 라우팅
app.post("/floor_plan", uploadFloorPlan);

// ------ 라즈베리파이 API ------
app.post("/receive_data", raspiReceive);

// 서버 종료 시 MySQL 연결 종료
process.on("SIGINT", () => {
  connection.end();
  process.exit();
});

// 서버 시작
const server = app.listen(port, () => {
  const { address, port } = server.address();
  console.log(`Server is running on http://${address}:${port}`);
  console.log(`address : ${address}`);
});
