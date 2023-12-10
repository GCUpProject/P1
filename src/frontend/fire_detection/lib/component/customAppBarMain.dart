import 'package:flutter/material.dart';
import './settingButton.dart';

class CustomAppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBarMain({
    required this.title,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // AppBar 배경색은 FFFFFF
      elevation: 0, // 그림자 없애기

      leading: Container(
        margin: EdgeInsets.all(8.0), // 여백 추가
        decoration: BoxDecoration(
          color: Colors.white, // 테두리 색상
          borderRadius: BorderRadius.circular(12), // 코너 반경
          border: Border.all(
            color: Color(0xFFE8ECF4), // 테두리 색상
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 40, // 적절한 가로 크기
            height: 40, // 적절한 세로 크기
            child: SettingButton(),
          ),
        ),
      ),

      title: Text(
        title,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E232C), // 타이틀 색상
        ),
      ),
    );
  }
}
