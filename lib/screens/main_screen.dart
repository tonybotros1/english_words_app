import 'package:english_words_app/consts.dart';
import 'package:english_words_app/models/words.dart';
import 'package:english_words_app/screens/add_new_word_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_screen_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController mainScreenController =
      Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffD6DAC8),
      appBar: AppBar(
        title: const Text(
          'All Words',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {
          Get.to(() => NewWordScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<MainScreenController>(
          init: MainScreenController(),
          builder: (controller) {
            return Card();
          }),
    );
  }
}
