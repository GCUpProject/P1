import 'package:flutter/material.dart';
import '../../component/customAppBar.dart';
import '../../component/customInput1.dart';
import '../../component/customButton.dart';

import './AdminPage.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController _indexController = TextEditingController();
  TextEditingController _adminKeyController = TextEditingController();
  String adminKey = "0000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '관리자 인증',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInput1(
              controller: _indexController,
              placeholder: '인덱스를 입력하세요.',
              onChanged: (value) {
                // 입력 값이 변경될 때 수행할 동작을 여기에 추가
              },
            ),
            SizedBox(height: 16),
            CustomInput1(
              controller: _adminKeyController,
              placeholder: '관리자 Key를 입력하세요.',
              onChanged: (value) {
                // 입력 값이 변경될 때 수행할 동작을 여기에 추가
              },
            ),
            SizedBox(height: 16),
            CustomButton(
              buttonText: '인증',
              onPressed: () {
                if (_adminKeyController.text == adminKey) {
                  // 인증 성공 시 처리
                  int index = int.tryParse(_indexController.text) ??
                      0; // 입력된 값을 정수로 변환, 실패 시 0으로 설정

                  // TODO: index를 사용하여 원하는 동작 수행

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPage(),
                    ),
                  );

                  // 성공 팝업
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('알림'),
                        content: Text('관리자 로그인 되었습니다 !'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('확인'),
                          ),
                        ],
                      );
                    },
                  );

                  print('인증 성공!');
                } else {
                  // 실패 시 오류 메시지 표시
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('오류'),
                        content: Text('관리자 Key가 다릅니다.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
