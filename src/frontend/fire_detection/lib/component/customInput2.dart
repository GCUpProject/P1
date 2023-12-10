import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInput2 extends StatelessWidget {
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final String? icon;
  final String? buttonText;
  final TextEditingController? controller;

  CustomInput2({
    this.placeholder,
    this.onChanged,
    this.icon,
    this.buttonText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160, // Increased width
          height: 36, // Increased height
          decoration: BoxDecoration(
            color: Color(0xFF1E232C),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 16), // Increased width
              SvgPicture.asset(
                icon!,
                color: Colors.white,
                height: 18, // Increased height
                width: 18, // Increased width
              ),
              SizedBox(width: 8), // Increased width
              Text(
                buttonText ?? '검색',
                style: TextStyle(
                  fontSize: 16, // Increased font size
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12), // Increased height
        Container(
          width: 340, // Increased width
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFF7F8F9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFE8ECF4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 16, // Increased font size
                  color: Color(0xFF8391A1),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
