import 'package:english_words_app/models/words.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

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
  bool hasChanges = false;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;
    if (argument is Word) {
      enword = argument.enWord;
      arword = argument.arWord;
      date = argument.date;
      description = argument.description;
      favorite = argument.favorite ?? 0;
      id = argument.id;
    }

    flutterTts.setCompletionHandler(() {
      isPlaying = false;
      update();
    });
    flutterTts.setCancelHandler(() {
      isPlaying = false;
      update();
    });
  }

  Future<void> deleteData() async {
    if (id == null) {
      return;
    }

    final dbHelper = DatabaseHelper();
    await dbHelper.delete(
      DatabaseHelper.wordsTable,
      DatabaseHelper.idColumn,
      id!,
    );
    hasChanges = true;
  }

  Future<void> speakEN() async {
    await _speak(enword, 'en-US');
  }

  Future<void> speakAR() async {
    await _speak(arword, 'ar-SY');
  }

  Future<void> _speak(String? text, String language) async {
    final value = text?.trim() ?? '';
    if (value.isEmpty) {
      return;
    }

    if (isPlaying) {
      await flutterTts.stop();
      isPlaying = false;
      update();
      return;
    }

    isPlaying = true;
    update();
    await flutterTts.setLanguage(language);
    await flutterTts.speak(value);
  }

  Future<void> addToFavorite() async {
    if (id == null) {
      return;
    }

    final value = favorite == 1 ? 0 : 1;
    favorite = value;
    final dbHelper = DatabaseHelper();
    await dbHelper.update(
      DatabaseHelper.wordsTable,
      {DatabaseHelper.favoriteColumn: value},
      DatabaseHelper.idColumn,
      id!,
    );
    hasChanges = true;
    update();
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }
}
