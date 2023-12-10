import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  CustomButton2({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8), // Added padding
      child: SizedBox(
        width: 70,
        height: 35,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1E232C), // 버튼 색상
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100), // 모서리 반지름
            ),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white, // 텍스트 색상
                fontSize: 11,
                fontWeight: FontWeight.bold, // 텍스트 굵게
              ),
            ),
          ),
        ),
      ),
    );
  }
}
