import 'package:flutter/material.dart';

class CustomInput1 extends StatelessWidget {
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller; // Add controller property

  CustomInput1({
    this.placeholder,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 331,
      height: 56,
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
          controller: controller ??
              TextEditingController(
                  text: '0'), // Set to 0 if controller is null
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 15,
              color: Color(0xFF8391A1),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
