import 'package:flutter/material.dart';
import '../../component/customAppBar.dart';

class SensorDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '센서 데이터 확인',
        onBack: () {
          // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Text('센서 데이터 확인 페이지 내용'),
      ),
    );
  }
}
