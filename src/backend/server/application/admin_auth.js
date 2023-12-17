const express = require("express");
const mysql = require("mysql");
const crypto = require("crypto");
const dbConfig = require("../dbconfig");
const cors = require("cors"); // cors 추가

const app = express();
const router = express.Router();

router.use(express.json());
router.use(express.urlencoded({ extended: false }));
app.use(cors()); // cors 사용

const connection = mysql.createConnection(dbConfig);

// SHA-512로 입력한 비밀번호 해시화
function hashPassword(admin_password, salt) {
  const hash = crypto.createHmac("sha512", salt);
  hash.update(admin_password);
  return hash.digest("hex");
}

// // Function to generate a random salt
// function generateSalt() {
//   return crypto.randomBytes(16).toString("hex");
// }

// POST 요청 처리 (관리자 인증)
const adminAuth = (req, res) => {
  let body = req.body;

  console.log("post요청 받음");
  console.log("Received data from client:", req.body);
  try {
    const data = req.body; // 받은 JSON 데이터를 파싱합니다.
    console.log("Received Data:", data);

    const { admin_password } = data;

    // DB에서 저장된 관리자 비밀번호 및 솔트 조회
    const query = "SELECT password, salt FROM admin";
    connection.query(query, 4, (err, results) => {
      if (err) {
        console.error("MySQL에서 데이터를 조회하는 중 오류 발생:", err);
        return res
          .status(500)
          .json({ status: "error", message: "서버 오류 발생" });
      }

      // if (results.length === 0) {
      //   // 해당 인덱스의 행이 없음
      //   return res.status(404).json({
      //     status: "error",
      //     message: "해당 번호의 관리자가 존재하지 않습니다.",
      //   });
      // }

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
    return res.status(500).json({
      status: "error",
      message: "관리자 인증 중 오류가 발생했습니다.",
    });
  }
};

router.post("/admin_auth", adminAuth);

module.exports = router;
