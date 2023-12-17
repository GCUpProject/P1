// mapRoutes.js
const express = require('express');
const router = express.Router();
const { exec } = require('child_process');
const path = require('path');

const resultMapRead = (req, res) => {
  // db_to_image.py를 실행하는 명령어
  const pythonCommand = 'python3 /home/t23320/P1/src/backend/fp_datas/db_to_image.py';

  // exec 함수를 사용하여 db_to_image.py를 실행
  exec(pythonCommand, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error during script execution: ${error}`);
      return res.status(500).send('Internal Server Error');
    }

    // result.png 파일을 읽어서 클라이언트에게 전송
    const imagePath = '/home/t23320/P1/src/backend/fp_datas/result.png';
    setTimeout(() => {
        res.sendFile(path.resolve(imagePath), (err) => {
          if (err) {
            console.error('Error sending image:', err);
            res.status(500).send('Internal Server Error');
          } else {
            console.log('Image sent successfully');
          }
        });
    }, 1000);
  });
};

router.get('/map', resultMapRead);

module.exports = router;
