const express = require("express");
const router = express.Router();
const bodyParser = require("body-parser");
const mysql = require("mysql");
const crypto = require("crypto");
const dbConfig = require("../dbconfig");

const app = express();
app.use(bodyParser.json()); // JSON 형식의 요청 데이터를 파싱

const connection = mysql.createConnection(dbConfig);

// SHA-512로 입력한 비밀번호 해시화
function hashPassword(password, salt) {
  const hash = crypto.createHmac("sha512", salt);
  hash.update(password);
  return hash.digest("hex");
}

// // Function to generate a random salt
// function generateSalt() {
//   return crypto.randomBytes(16).toString("hex");
// }

// POST 요청 처리 (관리자 인증)
app.post("/admin/auth", (req, res) => {
  try {
    const { admin_index, admin_password } = req.body; // 클라이언트에서 전송된 인덱스와 관리자 인증 비밀번호
    console.log(req.body);

    // DB에서 저장된 관리자 비밀번호 및 솔트 조회
    const query = "SELECT password, salt FROM admin WHERE index = ?";
    connection.query(query, [admin_index], (err, results) => {
      if (err) {
        console.error("MySQL에서 데이터를 조회하는 중 오류 발생:", err);
        return res
          .status(500)
          .json({ status: "error", message: "서버 오류 발생" });
      }

      if (results.length === 0) {
        // 해당 인덱스의 행이 없음
        return res
          .status(404)
          .json({
            status: "error",
            message: "해당 번호의 관리자가 존재하지 않습니다.",
          });
      }

      const storedPassword = results[0].password;
      const salt = results[0].salt;

      // 입력된 비밀번호와 데이터베이스에서 가져온 솔트를 사용하여 해싱
      const hashedPassword = hashPassword(admin_password, salt);

      if (hashedPassword === storedPassword) {
        // 비밀번호 일치: 관리자 메뉴로 이동
        return res
          .status(200)
          .json({ status: "success", message: "관리자로 인증되었습니다." });
      } else {
        // 비밀번호 불일치
        return res
          .status(401)
          .json({ status: "error", message: "비밀번호가 일치하지 않습니다." });
      }
    });
  } catch (error) {
    console.error("오류:", error);
    return res
      .status(500)
      .json({
        status: "error",
        message: "관리자 인증 중 오류가 발생했습니다.",
      });
  }
});

module.exports = router;
