import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;

  CustomAppBar({
    required this.title,
    required this.onBack,
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
        child: IconButton(
          iconSize: 18.0, // 아이콘 크기 조절
          icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
          color: Color(0xFF1E232C), // 뒤로가기 아이콘 색상
          onPressed: () {
            // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
            Navigator.pop(context);
          },
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

      actions: <Widget>[
        // 추가적인 액션 아이콘 등이 있다면 여기에 추가
      ],
    );
  }
}
