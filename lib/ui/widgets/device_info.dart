import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../src/constants.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key, required this.device});

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    BluetoothCharacteristic? heartRateCharacteristic;

    return StreamBuilder<BluetoothDeviceState>(
      stream: device.state,
      initialData: BluetoothDeviceState.connecting,
      builder: (context, snapshot) {
        if (snapshot.data == BluetoothDeviceState.connected) {
          List<BluetoothService> services = [];
          _getServices().then((value) => services = value);

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
              TextButton(
                onPressed: () async {
                  if (heartRateCharacteristic == null) {
                    _getHeartRateCharacteristic(services).then((value) {
                      if (value != null) {
                        heartRateCharacteristic = value;
                        heartRateCharacteristic!.setNotifyValue(true);
                        heartRateCharacteristic!.value.listen((value) {
                          if (value.isNotEmpty) {
                            print(value[1]);
                          }
                        });
                      }
                    });
                  }
                },
                child: const Text('Get heart rate'),
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

  Future<List<BluetoothService>> _getServices() async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((element) {
      print('UUID: ${element.uuid}');
    });
    return services;
  }
}

Future<BluetoothCharacteristic?> _getHeartRateCharacteristic(
  List<BluetoothService> services,
) async {
  BluetoothCharacteristic? heartRateCharacteristic;

  for (var element in services) {
    if (element.uuid == Guid(heartRateMeasurementCharacteristicUuid)) {
      heartRateCharacteristic = element.characteristics.first;
    }
  }

  return heartRateCharacteristic;
}
