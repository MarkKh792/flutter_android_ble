import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothDeviceState>(
      stream: device.state,
      initialData: BluetoothDeviceState.connecting,
      builder: (context, snapshot) {
        VoidCallback? onPressed;
        String title;
        Color buttonColor;

        if (snapshot.data == BluetoothDeviceState.connected) {
          title = 'Disconnect';
          buttonColor = Colors.green;
          onPressed = () => device.disconnect();
        } else {
          buttonColor = Colors.transparent;
          title = 'Disconnected';
          onPressed = null;
        }

        return snapshot.data == BluetoothDeviceState.connected
            ? Column(
                children: [
                  Text('Connected to: ${device.name} (${device.id})'),
                  Container(
                    color: buttonColor,
                    height: 50,
                    width: 200,
                    child: TextButton(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 25),
                      ),
                      onPressed: () => onPressed,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
