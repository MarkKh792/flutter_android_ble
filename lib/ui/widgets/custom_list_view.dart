import 'package:flutter/material.dart';
import 'package:flutter_android_ble/main.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../src/constants.dart';
import '../../src/enums.dart';
import 'device_info.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({
    super.key,
    required this.searchStatus,
  });

  final DeviceSearchStatus searchStatus;

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  BluetoothDevice? device;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanResult>>(
      stream: flutterBlue.scanResults,
      initialData: const [],
      builder: (context, snapshot) {
        List<ScanResult> scanResults = [];

        for (var r in snapshot.data!) {
          if (r.device.name.isNotEmpty) {
            scanResults.add(r);
          }
        }
        return Column(
          children: [
            SizedBox(height: 400, child: _buildChild(scanResults)),
            device != null
                ? DeviceInfo(device: device!)
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }

  Widget _buildChild(List<ScanResult> scanResults) {
    if (scanResults.isNotEmpty) {
      return Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < scanResults.length; i++)
              ListTile(
                isThreeLine: false,
                title: Text(scanResults[i].device.name,
                    style: const TextStyle(fontSize: 30)),
                minVerticalPadding: 10,
                subtitle: Text(
                  'MAC: ${scanResults[i].device.id}\nConnectable: ${scanResults[i].advertisementData.connectable}',
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: (scanResults[i].advertisementData.connectable)
                    ? () {
                        scanResults[i].device.connect();
                        setState(
                          () {
                            device = scanResults[i].device;
                          },
                        );
                      }
                    : null,
              ),
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
