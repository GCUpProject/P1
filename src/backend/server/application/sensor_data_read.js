const express = require("express");
const router = express.Router();
const mysql = require("mysql");
const dbConfig = require("../dbconfig");

const app = express();

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// ------- 센서 데이터 최근 10개 조회 -------
const sensorDataRead = (req, res) => {
  try {
    // MySQL에서 해당 센서의 데이터 조회
    const query = `SELECT data.*, sensor.space_name FROM data JOIN sensor ON data.sensor_id = sensor.sensor_id ORDER BY data.created_at DESC LIMIT 10;`;
    connection.query(query, (err, results) => {
      if (err) {
        console.error("MySQL에서 데이터를 조회하는 중 오류 발생:", err);
        throw err;
      }

      // 조회된 데이터를 클라이언트에 응답
      const responseData = {
        status: "success",
        data: results,
      };
      console.log(responseData);
      res.status(200).json(responseData);
    });
  } catch (error) {
    console.error("오류:", error);
    const response = {
      status: "error",
      message: "센서 데이터 검색에 실패했습니다.",
    };
    res.status(500).json(response);
  }
};

// ------- 센서 ID로 각 센서의 데이터 조회 -------
const sensorDataReadById = (req, res) => {
  try {
    const sensorId = req.params.sensor_id;

    // MySQL에서 해당 센서의 데이터 조회
    const checkSensorQuery =
      "SELECT COUNT(*) AS sensorCount FROM sensor WHERE sensor_id = ?";

    connection.query(checkSensorQuery, [sensorId], (checkErr, checkResults) => {
      if (checkErr) {
        console.error("MySQL에서 센서 확인 중 오류 발생:", checkErr);
        throw checkErr;
      }

      const sensorCount = checkResults[0].sensorCount;

      if (sensorCount === 0) {
        // 센서가 존재하지 않는 경우 404 에러 반환
        const notFoundResponse = {
          status: "error",
          message: "센서를 찾을 수 없습니다.",
        };
        res.status(404).json(notFoundResponse);
      } else {
        // 센서가 존재하는 경우 데이터 조회
        const query = `SELECT data.*, sensor.space_name FROM data JOIN sensor ON data.sensor_id = sensor.sensor_id WHERE data.sensor_id = ? ORDER BY data.created_at DESC LIMIT 10;`;

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
          console.log(responseData);
          res.status(200).json(responseData);
        });
      }
    });
  } catch (error) {
    console.error("오류:", error);
    const response = {
      status: "error",
      message: "센서 데이터 검색에 실패했습니다.",
    };
    res.status(500).json(response);
  }
};

router.get("/sensor_data", sensorDataRead);
router.get("/sensor_data/:sensor_id", sensorDataReadById);

module.exports = router;
