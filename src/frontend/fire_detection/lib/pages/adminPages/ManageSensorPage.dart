import 'package:flutter/material.dart';
import '../../component/customAppBar.dart';
import '../../component/sensorInfo.dart';

class ManageSensorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 서버에서 받아온 센서 정보 리스트 (예시로 7개의 센서 정보를 생성)
    List<SensorData> sensorDataList = [
      SensorData(
        dynamicSensorId: '1',
        dynamicRoomName: '거실',
        dynamicConnectedSensorId: '2, 3, 4',
        dynamicExitStatus: true,
      ),
      SensorData(
        dynamicSensorId: '2',
        dynamicRoomName: '침실',
        dynamicConnectedSensorId: '5, 6',
        dynamicExitStatus: false,
      ),
      SensorData(
        dynamicSensorId: '3',
        dynamicRoomName: '주방',
        dynamicConnectedSensorId: '7, 8',
        dynamicExitStatus: true,
      ),
      SensorData(
        dynamicSensorId: '4',
        dynamicRoomName: '욕실',
        dynamicConnectedSensorId: '9, 10',
        dynamicExitStatus: false,
      ),
      SensorData(
        dynamicSensorId: '5',
        dynamicRoomName: '서재',
        dynamicConnectedSensorId: '11, 12',
        dynamicExitStatus: true,
      ),
      SensorData(
        dynamicSensorId: '6',
        dynamicRoomName: '다용도실',
        dynamicConnectedSensorId: '13, 14',
        dynamicExitStatus: false,
      ),
      SensorData(
        dynamicSensorId: '7',
        dynamicRoomName: '안방',
        dynamicConnectedSensorId: '15, 16',
        dynamicExitStatus: true,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: '센서 관리',
        onBack: () {
          // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sensorDataList.length,
          itemBuilder: (context, index) {
            // 각 센서 정보에 대한 위젯 생성
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // 아래쪽 간격 추가
              child: SensorInfo(
                dynamicSensorId: sensorDataList[index].dynamicSensorId,
                dynamicRoomName: sensorDataList[index].dynamicRoomName,
                dynamicConnectedSensorId:
                    sensorDataList[index].dynamicConnectedSensorId,
                dynamicExitStatus: sensorDataList[index].dynamicExitStatus,
              ),
            );
          },
        ),
      ),
    );
  }
}

class SensorData {
  final String dynamicSensorId;
  final String dynamicRoomName;
  final String dynamicConnectedSensorId;
  final bool dynamicExitStatus;

  SensorData({
    required this.dynamicSensorId,
    required this.dynamicRoomName,
    required this.dynamicConnectedSensorId,
    required this.dynamicExitStatus,
  });
}
