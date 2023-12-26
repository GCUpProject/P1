# P프로젝트 1조 (Dove V)

\*🚨 스마트 화재감지기 서비스 개발 \*


---

## 🗂️ 디렉터리 구성

- Presentation : 파워포인트 발표 자료
- Document : 설계서 등 문서 자료
- src : 소스 코드
  
  📦src
  
 ┣ 📂backend
 
 ┃ ┣ 📂fp_datas
 
 ┃ ┃ ┣ 📂images
 
 ┃ ┣ 📂raspi-connection
 
 ┃ ┃ ┣ 📂local-raspi
 
 ┃ ┃ ┣ 📂remote-raspi
 
 ┃ ┃ ┃ ┣ 📂receive
 
 ┃ ┃ ┃ ┗ 📂send
 
 ┃ ┗ 📂server
 
 ┗ 📂frontend
 
** /src 폴더를 backend, frontend로 나누어 개발 **
backend/fp_datas : OCR을 통한 도면도 인식 알고리즘 소스코드 (python)
       /fp_datas/images : 앱에서 업로드한 도면도 이미지 저장 경로
       /raspi-connection/local-raspi : 센서 모듈 관리용(감지기) 라즈베리파이 소스코드 (python)
       /raspi-connection/remote-raspi : 센서 데이터 취합용(수신기) 라즈베리파이 소스코드 (python, node.js)
       /raspi-connection/remote-raspi/receive : 감지기 -> 수신기 데이터 수신용
       /raspi-connection/remote-raspi/send : 수신기 -> 서버 데이터 전송용
       /server : DB 서버 소스코드 (node.js)

## 🖥️ 서버

- 도메인 : ceprj.gachon.ac.kr
- 포트 : 60035
