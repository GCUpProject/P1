// sensorRoutes.js
const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const dbConfig = require('../dbconfig');

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// 전체 센서 조회
const sensorReadAll = (req, res) => {
  const query = 'SELECT * FROM sensor ORDER BY sensor_id';
  connection.query(query, (error, results) => {
    if (error) {
      console.error('Database error:', error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    console.log(results);
    return res.status(200).json(results);
  });
}

// // 방 번호로 센서 조회
// const sensorReadBySpaceId = (req, res) => {
//     try {
//         const spaceId = req.params.space_id;

//         // 해당 방 번호가 없을 경우 에러 발생
//         if (!spaceId) {
//             return res.status(400).json({ error: 'Missing space_id parameter' });
//         }
  
//       // MySQL에서 해당 방 번호의 센서 조회
//       const query = 'SELECT * FROM sensor WHERE space_id = ? ORDER BY sensor_id';
//       connection.query(query, [spaceId], (err, results) => {
//         if (err) {
//           console.error("MySQL에서 데이터를 조회하는 중 오류 발생:", err);
//           throw err;
//         }
  
//         // 조회된 데이터를 클라이언트에 응답
//         const responseData = {
//           status: "success",
//           data: results,
//         };
//         res.status(200).json(responseData);
//       });
//     } catch (error) {
//       console.error("오류:", error);
//       const response = {
//         status: "error",
//         message: "센서 조회에 실패했습니다.",
//       };
//       res.status(500).json(response);
//     }
// };

router.get("/sensor", sensorReadAll);
// router.get("/sensor/:space_id", sensorReadBySpaceId);

module.exports = router;
