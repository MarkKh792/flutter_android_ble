import 'package:flutter/material.dart';

import '../../src/constants.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    bool noDevicesFound = false;

    return SizedBox(
      height: 600,
      child: !noDevicesFound
          ? Scrollbar(
              child: ListView(
                children: [
                  for (int i = 0; i < devices.length; i++)
                    ListTile(
                      title: Text(devices[i],
                          style: const TextStyle(fontSize: 30)),
                      minVerticalPadding: 10,
                      subtitle: Text(
                        'MAC: $devices[i]',
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
