import 'package:flutter/material.dart';
import '../../component/customAppBar.dart';
import '../../component/customInput2.dart';
import '../../component/customButton.dart';

class InitialSettingPage extends StatefulWidget {
  @override
  _InitialSettingPageState createState() => _InitialSettingPageState();
}

class _InitialSettingPageState extends State<InitialSettingPage> {
  TextEditingController sensorIdController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController connectWithController = TextEditingController();
  TextEditingController exitStatusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '초기 정보 관리',
        onBack: () {
          // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Center align items
            children: [
              CustomInput2(
                controller: sensorIdController,
                placeholder: '센서 ID를 입력하세요. ex) 1',
                icon: "assets/icons/sensor.svg",
                buttonText: 'Sensor ID',
              ),
              SizedBox(height: 12), // Adjusted spacing
              CustomInput2(
                controller: roomController,
                placeholder: '사용자 지정명을 입력하세요. ex) 안방, 거실',
                icon: "assets/icons/door.svg",
                buttonText: 'Room',
              ),
              SizedBox(height: 12), // Adjusted spacing
              CustomInput2(
                controller: connectWithController,
                placeholder: '연결된 센서를 입력하세요. ex) 1, 2, 3',
                icon: "assets/icons/connection.svg",
                buttonText: 'Connect With',
              ),
              SizedBox(height: 12), // Adjusted spacing
              CustomInput2(
                controller: exitStatusController,
                placeholder: '탈출구 여부를 입력하세요. ex) O/X',
                icon: "assets/icons/exit.svg",
                buttonText: 'Exit Status',
              ),
              SizedBox(height: 16), // Adjusted spacing
              CustomButton(
                buttonText: '제출',
                onPressed: () {
                  // 입력된 값들
                  String sensorId = sensorIdController.text;
                  //String room = roomController.text;
                  String connectWith = connectWithController.text;
                  String exitStatus = exitStatusController.text;

                  // 유효성 검사
                  bool isValidSensorId = isNumeric(sensorId);
                  bool isValidConnectWith =
                      isValidConnectWithString(connectWith);
                  bool isValidExitStatus = isValidExitStatusBool(exitStatus);

                  // 모든 조건이 충족되면 동작
                  if (isValidSensorId &&
                      isValidConnectWith &&
                      isValidExitStatus) {
                    // 제출 버튼 클릭 시 수행할 동작
                    print('제출 버튼 클릭!');
                  } else {
                    // 유효성 검사에 실패한 경우 팝업으로 메시지 출력
                    _showValidationErrorDialog(
                        isValidSensorId, isValidConnectWith, isValidExitStatus);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 숫자인지 확인하는 함수
  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    bool result = double.tryParse(s) != null;
    return result;
  }

  // ConnectWith의 유효성 검사
  bool isValidConnectWithString(String? s) {
    if (s == null) {
      return false;
    }
    bool result = RegExp(r'^[\d, ]+$').hasMatch(s);
    return result;
  }

  // ExitStatus의 유효성 검사
  bool isValidExitStatusBool(String? s) {
    if (s == null) {
      return false;
    }
    bool result = s.toUpperCase() == 'O' ||
        s.toUpperCase() == 'X' ||
        s.toUpperCase() == 'o' ||
        s.toUpperCase() == 'x';
    return result;
  }

  // 유효성 검사 실패 시 팝업 메시지 출력
  Future<void> _showValidationErrorDialog(bool isValidSensorId,
      bool isValidConnectWith, bool isValidExitStatus) async {
    List<String> invalidFields = [];

    if (!isValidSensorId) {
      invalidFields.add('Sensor ID');
    }

    if (!isValidConnectWith) {
      invalidFields.add('Connect With');
    }

    if (!isValidExitStatus) {
      invalidFields.add('Exit Status');
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('입력값이 유효하지 않습니다.'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('다음 항목을 확인하세요:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                for (String field in invalidFields) Text('- $field'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
