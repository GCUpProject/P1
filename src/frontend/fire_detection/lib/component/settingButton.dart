import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pages/adminPages/AuthenticationPage.dart';

class SettingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 버튼을 클릭하면 설정 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthenticationPage(),
          ),
        );
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white, // 배경 색상을 흰색으로 변경
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/setting.svg",
            height: 30.0, // 아이콘 높이 조절
            width: 30.0, // 아이콘 너비 조절
            color: Color(0xFF1E232C), // 아이콘 색상
          ),
        ),
      ),
    );
  }
}
