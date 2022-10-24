import 'package:flutter/material.dart';
import 'package:flutter_android_ble/main.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../src/constants.dart';
import '../../src/enums.dart';

class CustomListView extends StatefulWidget {
  final List<BluetoothDevice> devices;
  final DeviceSearchStatus searchStatus;

  const CustomListView({
    super.key,
    required this.devices,
    required this.searchStatus,
  });

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: StreamBuilder<List<ScanResult>>(
        stream: flutterBlue.scanResults,
        initialData: const [],
        builder: (context, snapshot) {
          List<ScanResult> scanResults = [];

          for (var r in snapshot.data!) {
            if (r.device.name.isNotEmpty) {
              scanResults.add(r);
            }
          }
          return _buildChild(scanResults);
        },
      ),
    );
  }

  Widget _buildChild(List<ScanResult> scanResults) {
    if (scanResults.isNotEmpty) {
      return Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < scanResults.length; i++)
              ListTile(
                title: Text(scanResults[i].device.name,
                    style: const TextStyle(fontSize: 30)),
                minVerticalPadding: 10,
                subtitle: Text(
                  'MAC: ${scanResults[i].device.id}',
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  throw UnimplementedError('Implement bluetooth connection');
                },
              )
          ],
        ),
      );
    }

    return const Center(
        child: Text(
      noDevicesFoundText,
      style: TextStyle(fontSize: 30),
    ));
  }
}
