import 'package:flutter/material.dart';

class DialKeyboard extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onDeletePressed;

  DialKeyboard({
    required this.onNumberPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 아이폰 스타일에 따라 배경 색상 변경
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildRow(['1', '2', '3']),
          SizedBox(height: 8.0),
          buildRow(['4', '5', '6']),
          SizedBox(height: 8.0),
          buildRow(['7', '8', '9']),
          SizedBox(height: 8.0),
          buildRow(['', '0', 'del']),
        ],
      ),
    );
  }

  Widget buildRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map((button) => Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: buildButton(
                    button,
                    button == 'del'
                        ? onDeletePressed
                        : () => onNumberPressed(button),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget buildButton(String label, VoidCallback onPressed) {
    return Container(
      width: 117.0,
      height: 46.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // 아이폰 스타일에 맞게 둥근 모서리 적용
          ),
          elevation: 2.0, // 아이폰 스타일의 그림자 추가
        ),
        child: label == 'del'
            ? Icon(Icons.delete_outline)
            : Text(label), // 아이폰 스타일의 아이콘 및 텍스트로 변경
      ),
    );
  }
}
