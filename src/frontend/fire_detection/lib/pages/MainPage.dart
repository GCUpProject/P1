import 'package:flutter/material.dart';
import '../component/customButton.dart';
import '../component/customAppBarMain.dart';

import './userPages/SensorDataPage.dart';
import './userPages/EvacuationRoutePage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // initState가 완료된 후에 포커스를 주어 키보드를 띄웁니다.
      if (context != null) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBarMain(
          title: '메인 메뉴',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image 부분은 그대로 유지
              Image.asset(
                'assets/images/landing_image.jpg',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 16),
              // 센서 데이터 확인 버튼
              CustomButton(
                buttonText: '센서 데이터 확인',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SensorDataPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              // 대피도 확인 버튼
              CustomButton(
                buttonText: '대피도 확인',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EvacuationRoutePage(),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              // 투명한 텍스트 필드
              TextField(
                onChanged: (text) {
                  // 텍스트 변경 이벤트 처리
                  // 필요한 로직 추가
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent, // 배경색 투명 설정
                  hintText: '투명한 텍스트 필드',
                  hintStyle:
                      TextStyle(color: Colors.transparent), // 힌트 텍스트 투명 설정
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
