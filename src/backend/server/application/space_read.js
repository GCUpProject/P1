const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const dbConfig = require('../dbconfig');

// MySQL 연결 생성
const connection = mysql.createConnection(dbConfig);

// 특정 space_id에 해당하는 공간 데이터 조회
const spaceRead = (req, res) => {

  const query = 'SELECT name FROM space';
  connection.query(query, (error, results) => {
    if (error) {
      console.error("MySQL에서 데이터를 조회하는 중 오류 발생:", error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (results.length === 0) {
      return res.status(404).json({ error: 'No data in table `space`.' });
    }

    // 조회된 데이터를 클라이언트에 응답
    const responseData = {
      status: "success",
      data: results, // 여기서는 첫 번째 행만 반환하도록 설정
    };
    console.log(responseData);
    res.status(200).json(responseData);
  });
};

router.get("/space", spaceRead);

module.exports = router;
