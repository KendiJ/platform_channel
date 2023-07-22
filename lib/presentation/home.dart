import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Construct a chanell
  static const myChanel = MethodChannel('com.example.flutter_native');

  // invoke a method on the method channel
  String _batteryLevel = 'Unknown batery leval';
  Future<void> _getBateryLeval() async {
    String bateryLeval;
    try {
      final int result = await myChanel.invokeMethod('getBatteryLevel');
      bateryLeval = 'Batery leval at $result % .';
    } on PlatformException catch (e) {
      bateryLeval = "Failed to get batery leval: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = bateryLeval;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _getBateryLeval,
              child: const Text('Get batery leval'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
