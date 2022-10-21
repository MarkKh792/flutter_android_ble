import 'package:flutter/material.dart';
import 'package:flutter_android_ble/ui/main_page.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE implementation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}
