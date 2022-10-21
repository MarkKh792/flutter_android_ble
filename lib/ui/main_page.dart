import 'package:flutter/material.dart';
import 'package:flutter_android_ble/ui/widgets/custom_list_view.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../main.dart';
import '../src/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BluetoothDevice> devices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomListView(
            devices: devices,
          ),
          Container(
              color: Colors.black12,
              height: 100,
              width: 300,
              child: TextButton(
                child: const Text(
                  findText,
                  style: TextStyle(fontSize: 50),
                ),
                onPressed: () => setState(() {
                  devices = _getDevices();
                }),
              ))
        ],
      ),
    );
  }

  List<BluetoothDevice> _getDevices() {
    List<BluetoothDevice> devices = [];
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    var scanSubscription = flutterBlue.scanResults.listen((results) {
      for (var element in results) {
        if (element.device.name.isNotEmpty) {
          devices.add(element.device);
          print('${element.device.name} found! rssi: ${element.rssi}');
        }
      }
    });

    flutterBlue.stopScan();

    return devices;
  }
}
