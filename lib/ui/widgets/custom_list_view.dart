import 'package:flutter/material.dart';
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
      child: _buildChild(widget.searchStatus, widget.devices),
    );
  }

  Widget _buildChild(
      DeviceSearchStatus searchStatus, List<BluetoothDevice> devices) {
    if (searchStatus == DeviceSearchStatus.inProgress) {
      return const Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (searchStatus == DeviceSearchStatus.searchSucceeded) {
      return Scrollbar(
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
