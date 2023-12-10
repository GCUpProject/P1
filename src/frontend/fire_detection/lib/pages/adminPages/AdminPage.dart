import 'package:flutter/material.dart';
import '../../component/customButton.dart';
import '../../component/customAppBar.dart';

import './InitialSettingPage.dart';
import './ManageSensorPage.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '관리자 메뉴',
        onBack: () {
          // 뒤로가기 버튼을 눌렀을 때 수행할 동작 추가
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              buttonText: '초기 정보 관리',
              onPressed: () {
                // 초기 정보 관리 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InitialSettingPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 16), // 적절한 간격 조절
            CustomButton(
              buttonText: '센서 관리',
              onPressed: () {
                // 버튼이 클릭되었을 때 수행할 동작을 여기에 추가
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageSensorPage(),
                  ),
                );
                print('센서 관리 버튼 클릭!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
