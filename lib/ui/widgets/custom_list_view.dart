import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../src/constants.dart';

class CustomListView extends StatefulWidget {
  final List<BluetoothDevice> devices;

  const CustomListView({super.key, required this.devices});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    bool noDevicesFound = true;

    if (widget.devices.isNotEmpty) {
      noDevicesFound = false;
    }

    return SizedBox(
      height: 600,
      child: !noDevicesFound
          ? Scrollbar(
              child: ListView(
                children: [
                  for (int i = 0; i < widget.devices.length; i++)
                    ListTile(
                      title: Text(widget.devices[i].name,
                          style: const TextStyle(fontSize: 30)),
                      minVerticalPadding: 10,
                      subtitle: Text(
                        'MAC: ${widget.devices[i].id}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        throw UnimplementedError(
                            'Implement bluetooth connection');
                      },
                    )
                ],
              ),
            )
          : const Center(
              child: Text(
              noDevicesFoundText,
              style: TextStyle(fontSize: 30),
            )),
    );
  }
}
