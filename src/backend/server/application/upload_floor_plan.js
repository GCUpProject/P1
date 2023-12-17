const express = require('express');
const router = express.Router();
const multer = require('multer');
const { exec } = require('child_process');

// 파일 저장 경로 지정
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, '/home/t23320/dev/images');
  },
  filename: function (req, file, cb) {
    cb(null, 'floor_plan.png');
  },
});

const upload = multer({ storage: storage });

const uploadFloorPlan = (req, res) => {
  // 이미지를 성공적으로 저장한 후 OCR을 실행
  console.log('Image saved successfully');
  
  // OCR을 실행하는 명령어
  const ocrCommand = 'python3 ocr_to_db.py';

  // exec 함수를 사용하여 ocr_to_db.py를 실행
  exec(ocrCommand, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error during OCR: ${error}`);
      res.status(500).send('Internal Server Error');
      // 전송된 데이터 확인
      console.log('Received data:', req.file);
    } else {
      console.log(`OCR output: ${stdout}`);
      res.status(200).send('OCR completed successfully');
      // 전송된 데이터 확인
      console.log('Received data:', req.file);
    }
  });
};

router.post('/floor_plan', upload.single('floorPlan'), uploadFloorPlan);

module.exports = router;
