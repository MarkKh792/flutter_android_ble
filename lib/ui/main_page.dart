import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_android_ble/ui/widgets/custom_list_view.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../main.dart';
import '../src/constants.dart';
import '../src/enums.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BluetoothDevice> devices = [];
  DeviceSearchStatus noDevicesFound = DeviceSearchStatus.noDevicesFound;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomListView(
            devices: devices,
            searchStatus: noDevicesFound,
          ),
          const SizedBox(
            height: 50,
          ),
          StreamBuilder<bool>(
            stream: flutterBlue.isScanning,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data!) {
                return _buildScanButton(
                  Colors.amber,
                  stopScanText,
                  () => flutterBlue.stopScan(),
                );
              } else {
                return _buildScanButton(
                  Colors.black12,
                  startScanText,
                  () => flutterBlue.startScan(
                    timeout: const Duration(seconds: scanTime),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton(
    Color backgroundColor,
    String title,
    Function onPressed,
  ) {
    return Container(
      color: backgroundColor,
      height: 50,
      width: 150,
      child: TextButton(
        child: Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
        onPressed: () =>
            flutterBlue.startScan(timeout: const Duration(seconds: 4)),
      ),
    );
  }
}
