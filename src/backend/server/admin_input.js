const express = require("express");
const mysql = require("mysql");
const crypto = require("crypto");
const dbConfig = require("./dbconfig");

const app = express();

const connection = mysql.createConnection(dbConfig);

// Function to hash the password using SHA-512 with salt
function hashPassword(password, salt) {
  const hash = crypto.createHmac("sha512", salt);
  hash.update(password);
  return hash.digest("hex");
}

// Function to generate a random salt
function generateSalt() {
  return crypto.randomBytes(16).toString("hex");
}

// 비밀번호를 입력 받는 코드 (콘솔 창에서 실행)
const readline = require("readline");
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question("관리자 비밀번호를 입력하세요: ", (admin_password) => {
  // 비밀번호를 입력받았을 때의 처리
  rl.close();

  try {
    // 새로운 솔트 생성
    const salt = generateSalt();

    // 비밀번호와 솔트를 사용하여 해싱
    const hashedPassword = hashPassword(admin_password, salt);

    // DB에 저장
    const insertQuery = "INSERT INTO admin (password, salt) VALUES (?, ?)";
    connection.query(insertQuery, [hashedPassword, salt], (err, result) => {
      if (err) {
        console.error("MySQL에서 데이터를 삽입하는 중 오류 발생:", err);
        throw err;
      }

      console.log("관리자가 성공적으로 등록되었습니다.");
      console.log("삽입된 레코드의 index:", result.insertId);
      process.exit(); // 작업 완료 후 프로세스 종료
    });
  } catch (error) {
    console.error("오류:", error);
    console.log("관리자 등록 중 오류가 발생했습니다.");
    process.exit(1); // 오류 발생 시 프로세스 종료 (1은 비정상 종료를 나타냄)
  }
});

const PORT = process.env.PORT || 60035;
app.listen(PORT, () => {
  console.log(`서버가 ${PORT}번 포트에서 실행 중입니다.`);
});
