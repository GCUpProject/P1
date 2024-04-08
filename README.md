# P프로젝트 1조 (Dove V)

**🚨 스마트 화재감지기 서비스 개발**

---

## 🗂️ 디렉터리 구성

- **Presentation**: 파워포인트 발표 자료
- **Document**: 설계서 등 문서 자료
- **src**: 소스 코드
  
  - 📦 src
    - 📂 backend
      - 📂 fp_datas
        - 📂 images: 앱에서 업로드한 도면도 이미지 저장 경로
      - 📂 raspi-connection
        - 📂 local-raspi: 센서 모듈 관리용(감지기) 라즈베리파이 소스코드 (python)
        - 📂 remote-raspi
          - 📂 receive: 감지기 -> 수신기 데이터 수신용
          - 📂 send: 수신기 -> 서버 데이터 전송용
    - 📂 frontend

*src 폴더를 backend, frontend로 나누어 개발*
  
  
## 🖥️ 서버

- **도메인**: ceprj.gachon.ac.kr
- **포트**: 60035
  
  
## 🧑‍🤝‍🧑 팀원 구성
<table>
  <tr>
    <td align="center">
      <img src="https://avatars.githubusercontent.com/u/133775226?v=4" width="120px" height="15%"/>
    </td>
    <td align="center">
      <img src="https://avatars.githubusercontent.com/u/104813592?v=4" width="120px" height="15%"/>
    </td>
    <td align="center">
      <img src="https://avatars.githubusercontent.com/u/106008056?v=4" width="120px" height="15%"/>
    </td>
    <td align="center">
      <img src="https://avatars.githubusercontent.com/u/96415949?v=4" width="120px" height="15%"/>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/GyuPin-Moon">
      문규빈
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/nuyeo">
      구연우
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/doondu">
      김윤수
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/K1EH">
      최지태
      </a>
    </td>
  </tr>
  <tr>
    <td align="center" colspan="1">
      <b><strong>TeamLeader</strong></b><br>
      <b>AI & Algorithm</b><br>
      <b>Image Processing</b><br> 
    </td>
    <td align="center" colspan="1">
      <b>Backend</b>
    </td>
    <td align="center" colspan="1">
      <b>Embedded Programming</b>
    </td>
    <td align="center" colspan="1">
      <b>Frontend</b><br>
      <b>Android Application</b><br>
    </td>
  </tr>
</table>


![Slide1](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C1.JPG) 
![Slide2](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C2.JPG) 
![Slide3](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C3.JPG)
![Slide4](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C4.JPG)  
![Slide5](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C5.JPG)  
![Slide6](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C6.JPG)  
![Slide7](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C7.JPG)  
![Slide8](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C8.JPG)  
![Slide9](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C9.JPG)  
![Slide10](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C10.JPG)  
![Slide11](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C11.JPG)  
![Slide12](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C12.JPG))  
![Slide13](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C13.JPG)  
![Slide14](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C14.JPG)  
![Slide15](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C15.JPG)  
![Slide16](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C16.JPG)  
![Slide17](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C17.JPG)  
![Slide18](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C18.JPG)  
![Slide19](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C19.JPG)  
![Slide20](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C20.JPG)  
![Slide21](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C21.JPG)  
![Slide22](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C22.JPG)  
![Slide23](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C23.JPG)  
![Slide24](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C24.JPG)  
![Slide25](https://github.com/GCUpProject/P1/blob/93f54df3337cc1772e182c6496ec9c78a012a26f/Presentation/%EC%8A%A4%EB%A7%88%ED%8A%B8%20%ED%99%94%EC%9E%AC%20%EA%B0%90%EC%A7%80%EA%B8%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C25.JPG)  
