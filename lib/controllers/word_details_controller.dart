import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../utils/db_helper.dart';

class WordDetailsController extends GetxController {
  String? enword;
  String? arword;
  String? date;
  String? description;
  int? favorite;
  int? id;

  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  AnimationController? animationController;

  @override
  void onInit() {
    var argument = Get.arguments;
    if (argument != null) {
      enword = argument.enWord;
      arword = argument.arWord;
      date = argument.date;
      description = argument.description;
      favorite = argument.favorite;
      id = argument.id;
    }
    super.onInit();
  }

// function to delete the word card
  deleteData(id) async {
    var dbHelper = DatabaseHelper();
    await dbHelper.delete('wordsTable', 'id', id);
  }

// function to read English the words
  Future<void> speakEN(String text) async {
    isPlaying = true;
    update();
    await flutterTts.setLanguage('en-US'); // Set language to English
    await flutterTts.speak(text);
    isPlaying = false;
    update();
  }

// function to read Arabic words
  Future<void> speakAR(String text) async {
    isPlaying = true;
    update();
    await flutterTts.setLanguage('ar-SY');
    await flutterTts.speak(text);
    isPlaying = false;
    update();
  }

// this function to change the volume button icon when listening to the word
  changeVolumIcon() {
    if (isPlaying == true) {
      isPlaying = false;
    } else {
      isPlaying = true;
    }
    update();
  }
}
