import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './customButton2.dart';

class SensorInfo extends StatelessWidget {
  final String dynamicSensorId; // 서버에서 동적으로 받아온 Sensor ID
  final String dynamicRoomName; // 서버에서 동적으로 받아온 Room Name
  final String dynamicConnectedSensorId; // 서버에서 동적으로 받아온 Connected Sensor ID
  final bool dynamicExitStatus; // 서버에서 동적으로 받아온 Exit Status

  SensorInfo({
    required this.dynamicSensorId,
    required this.dynamicRoomName,
    required this.dynamicConnectedSensorId,
    required this.dynamicExitStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 215,
      decoration: BoxDecoration(
        color: Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFE8ECF4),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8), // 간격 조절
          _buildShape(
            icon: "assets/icons/sensor.svg",
            text: 'Sensor ID : $dynamicSensorId', // 동적으로 받아온 Sensor ID 표시
          ),
          SizedBox(height: 8), // 간격 조절
          _buildShape(
              icon: "assets/icons/door.svg",
              text: 'Room : $dynamicRoomName'), // 동적으로 받아온 Room Name 표시
          SizedBox(height: 8), // 간격 조절
          _buildShape(
              icon: "assets/icons/connection.svg",
              text:
                  'Connect With : $dynamicConnectedSensorId'), // 동적으로 받아온 Connected Sensor ID 표시
          SizedBox(height: 8), // 간격 조절

          // 알림, 제거 버튼 및 추가 도형
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAdditionalShape(
                  text: 'Exit Status : ', exitStatus: dynamicExitStatus),
              CustomButton2(
                buttonText: '알림',
                onPressed: () {
                  // 알림 버튼 클릭 시 수행할 동작
                  print('알림 버튼 클릭!');
                },
              ),
              CustomButton2(
                buttonText: '제거',
                onPressed: () {
                  // 제거 버튼 클릭 시 수행할 동작
                  print('제거 버튼 클릭!');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 세로로 배치된 도형의 함수
  Widget _buildShape({required String icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        width: 340,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFF1E232C),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // 좌측 정렬
          children: [
            SizedBox(width: 8), // 아이콘 좌측 간격
            SvgPicture.asset(
              icon,
              color: Colors.white, // 아이콘의 색상을 흰색으로 설정
              height: 24, // 아이콘의 높이를 14로 설정
              width: 24, // 아이콘의 너비를 14로 설정
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 알림, 제거 버튼 좌측에 추가된 도형의 함수
  // 알림, 제거 버튼 좌측에 추가된 도형의 함수
  Widget _buildAdditionalShape({
    required String text,
    required bool exitStatus,
  }) {
    Color iconColor = exitStatus ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        width: 170,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xFF1E232C),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/exit.svg",
              color: Colors.white,
              height: 24,
              width: 24,
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            SvgPicture.asset(
              exitStatus
                  ? "assets/icons/o.svg"
                  : "assets/icons/x.svg", // Exit Status에 따라 아이콘 변경
              color: iconColor, // Change icon color dynamically
              height: 24,
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}
