const express = require("express");
const router = express.Router();
const mysql = require("mysql");
const dbConfig = require("./dbConfig");

const connection = mysql.createConnection(dbConfig);

// POST 요청 처리 (관리자 인증)
router.post("/admin_auth", (req, res) => {
  try {
    const { admin_index, admin_password } = req.body; // 사용자가 입력한 인덱스와 관리자 인증 비밀번호

    // DB에서 저장된 관리자 비밀번호 조회
    const query = "SELECT password FROM admin WHERE index = ?";
    connection.query(query, [admin_index], (err, results) => {
      if (err) {
        console.error("MySQL에서 데이터를 조회하는 중 오류 발생:", err);
        throw err;
      }

      if (results.length === 0) {
        // 해당 인덱스의 행이 없음
        const response = {
          status: "error",
          message: "해당 인덱스의 관리자가 존재하지 않습니다.",
        };
        res.status(404).json(response); // 404는 찾을 수 없음을 의미합니다.
        return;
      }

      const storedPassword = results[0].password;

      // 입력한 비밀번호와 DB에 저장된 비밀번호 비교
      if (admin_password === storedPassword) {
        // 비밀번호 일치: 관리자 메뉴로 이동
        const response = {
          status: "success",
          message: "관리자로 인증되었습니다.",
        };
        res.status(200).json(response);
      } else {
        // 비밀번호 불일치
        const response = {
          status: "error",
          message: "비밀번호가 일치하지 않습니다.",
        };
        res.status(401).json(response); // 401은 권한 없음을 의미합니다.
      }
    });
  } catch (error) {
    console.error("오류:", error);
    const response = {
      status: "error",
      message: "관리자 인증 중 오류가 발생했습니다.",
    };
    res.status(500).json(response);
  }
});

module.exports = router;
