import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../component/customAppBar.dart';

class SensorDataPage extends StatefulWidget {
  const SensorDataPage({super.key});

  @override
  _SensorDataPageState createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  List<dynamic> sensorData = []; // List to store sensor data

  @override
  void initState() {
    super.initState();
    // Fetch sensor data when the widget is initialized
    fetchSensorData();
  }

  Future<void> fetchSensorData() async {
    try {
      // Replace with your backend URL
      final response = await http.get(
        Uri.parse('http://ceprj.gachon.ac.kr:60035/sensorData/1'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          setState(() {
            // Update the sensorData list with the fetched data
            sensorData = responseData['data'];
            print("--------------센서------------------");
            print(sensorData);
          });
        } else {
          // Handle other cases if needed
          print('Failed to fetch sensor data');
        }
      } else {
        // Handle non-200 status codes if needed
        print(
            'Failed to fetch sensor data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching sensor data: $error');

      if (error is http.Response) {
        // Print response details for HTTP-related errors
        print('Response status code: ${error.statusCode}');
        print('Response body: ${error.body}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '센서 데이터 확인',
        onBack: () {
          // Navigate back when the back button is pressed
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('센서 데이터 확인 페이지 내용'),
            const SizedBox(height: 20),
            // Display the fetched sensor data
            Expanded(
              child: ListView.builder(
                itemCount: sensorData.length,
                itemBuilder: (context, index) {
                  // Assuming the sensor data is a map with 'sensor_value' key
                  final sensorValue = sensorData[index]['sensor_value'];
                  return ListTile(
                    title: Text('Sensor Value: $sensorValue'),
                    // Add more details if needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
