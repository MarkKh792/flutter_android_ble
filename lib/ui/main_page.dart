import 'package:flutter/material.dart';
import 'package:flutter_android_ble/ui/widgets/custom_list_view.dart';

import '../src/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomListView(),
          Container(
              color: Colors.black12,
              height: 100,
              width: 300,
              child: TextButton(
                child: const Text(
                  findText,
                  style: TextStyle(fontSize: 50),
                ),
                onPressed: () {},
              ))
        ],
      ),
    );
  }
}
