import 'package:english_words_app/consts.dart';
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
        backgroundColor: mainColor,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Text('Add new word!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Close dialog
                  Get.back();
                },
                child: Text('OK'),
              ),
            ],
          ));
        },
        child: Icon(Icons.add),
      ),
      body: GetBuilder<MainScreenController>(
          init: MainScreenController(),
          builder: (controller) {
            return Card();
          }),
    );
  }
}
