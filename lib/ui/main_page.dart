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
          Container(
              color: Colors.black12,
              height: 50,
              width: 150,
              child: TextButton(
                child: const Text(
                  findText,
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () => _getDevices(),
              ))
        ],
      ),
    );
  }

  void _getDevices() {
    List<BluetoothDevice> bluetoothDevices = [];
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    setState(() {
      devices.clear();
      noDevicesFound = DeviceSearchStatus.inProgress;
    });

    Timer(
      const Duration(seconds: 4),
      () => setState(() {
        devices = bluetoothDevices;
        if (bluetoothDevices.isNotEmpty) {
          noDevicesFound = DeviceSearchStatus.searchSucceeded;
        } else {
          noDevicesFound = DeviceSearchStatus.noDevicesFound;
        }
      }),
    );

    var scanSubscription = flutterBlue.scanResults.listen((results) {
      for (var element in results) {
        if (element.device.name.isNotEmpty) {
          bluetoothDevices.add(element.device);
          print('${element.device.name} found! rssi: ${element.rssi}');
        }
      }
    });

    flutterBlue.stopScan();

    //return bluetoothDevices;
  }
}
