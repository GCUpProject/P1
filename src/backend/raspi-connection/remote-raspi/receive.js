const fs = require("fs");
const { execSync } = require("child_process");

const remoteHost = "192.168.4.1";
const remoteUser = "pi";
const remotePath = "/home/pi/pProj/";
const remoteFilename = "sensor_data.json";

const localPath = "./"; // 로컬 디렉토리는 원하는 경로로 변경할 수 있습니다.

const watchRemoteDirectory = () => {
  fs.watch(remotePath, (event, filename) => {
    if (event === "rename" && filename === remoteFilename) {
      console.log("새 파일이 감지되었습니다:", filename);
      copyFile();
    }
  });
};

const copyFile = () => {
  const scpCommand = `scp ${remoteUser}@${remoteHost}:${remotePath}${remoteFilename} ${localPath}`;
  try {
    execSync(scpCommand);
    console.log("파일이 성공적으로 복사되었습니다.");
  } catch (error) {
    console.error("파일 복사 중 오류 발생:", error.message);
  }
};

// 변경 사항 감지 시작
watchRemoteDirectory();
