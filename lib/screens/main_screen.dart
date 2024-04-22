import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffD6DAC8),
      appBar: AppBar(
        title: const Text('All Words'),
        centerTitle: true,
        backgroundColor: const Color(0xff2ed573),
      ),
      body: GetBuilder<MainScreenController>(
          init: MainScreenController(),
          builder: (controller) {
            return Card();
          }),
    );
  }
}
