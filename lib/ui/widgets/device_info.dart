import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../src/constants.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothDeviceState>(
      stream: device.state,
      initialData: BluetoothDeviceState.connecting,
      builder: (context, snapshot) {
        if (snapshot.data == BluetoothDeviceState.connected) {
          return Column(
            children: [
              Text('Connected to: ${device.name} (${device.id})'),
              Container(
                color: Colors.green,
                height: 50,
                width: 200,
                child: TextButton(
                  child: const Text(
                    disconnectText,
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () => device.disconnect(),
                ),
              ),
            ],
          );
        } else if (snapshot.data != BluetoothDeviceState.disconnected) {
          return const SizedBox(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
