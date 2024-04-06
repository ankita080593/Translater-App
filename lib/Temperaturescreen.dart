import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
class Temperaturescreen extends StatefulWidget {
  const Temperaturescreen({Key? key}) : super(key: key);

  @override
  State<Temperaturescreen> createState() => _TemperaturescreenState();
}

class _TemperaturescreenState extends State<Temperaturescreen> {
  late StreamController<double> streamController;
  late Timer timer;
  late double currentTemperature;

  @override
  void initState() {
    super.initState();
    currentTemperature = generateRandomTemperature();
    streamController = StreamController<double>();
    streamController.add(currentTemperature);
    startStreaming();
  }

  @override
  void dispose() {
    streamController.close();
    timer.cancel();
    super.dispose();
  }

  void startStreaming() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      currentTemperature = generateRandomTemperature();
      streamController.add(currentTemperature);
    });
  }

  double generateRandomTemperature() {
    return Random().nextInt(101).toDouble(); // Generate random temperature between 0 and 100
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real-Time Temperature Stream"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: StreamBuilder<double>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Current Temperature:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${snapshot.data!.toStringAsFixed(2)} °C",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
