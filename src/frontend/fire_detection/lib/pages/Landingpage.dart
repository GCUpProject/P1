import 'package:flutter/material.dart';
import './MainPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1초간 랜딩 페이지를 보여주고, 그 후에 MainPage로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '시야 보조형 스마트 화재 경보 시스템',
          style: TextStyle(fontWeight: FontWeight.bold), // 타이틀 폰트 굵게 설정
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 이미지 추가
            Image.asset(
              'assets/images/landing_image.jpg',
              width: 200, // 이미지의 너비 조절
              height: 200, // 이미지의 높이 조절
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.grey), // 로딩 아이콘을 회색으로 변경
            ),
            SizedBox(height: 20),
            Text(
              '© DoveV. All Rights Reserved.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
