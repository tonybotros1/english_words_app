import 'package:english_words_app/models/words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/db_helper.dart';

class EditWordController extends GetxController {
  final enWord = TextEditingController();
  final arWord = TextEditingController();
  final notes = TextEditingController();
  final loading = false.obs;
  int? id;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() {
    final arguments = Get.arguments;
    if (arguments is Word) {
      enWord.text = arguments.enWord ?? '';
      arWord.text = arguments.arWord ?? '';
      notes.text = arguments.description ?? '';
      id = arguments.id;
    }
  }

  Future<bool> editCard() async {
    final english = enWord.text.trim();
    final arabic = arWord.text.trim();
    final description = notes.text.trim();

    if (id == null) {
      Get.snackbar('Edit failed', 'This word does not have a database id.');
      return false;
    }

    if (english.isEmpty || arabic.isEmpty) {
      Get.snackbar('Missing word', 'English and Arabic words are required.');
      return false;
    }

    loading.value = true;
    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.update(
        DatabaseHelper.wordsTable,
        {
          DatabaseHelper.englishColumn: english,
          DatabaseHelper.arabicColumn: arabic,
          DatabaseHelper.descriptionColumn:
              description.isEmpty ? null : description,
        },
        DatabaseHelper.idColumn,
        id!,
      );
      return true;
    } catch (_) {
      Get.snackbar('Edit failed', 'The word could not be updated.');
      return false;
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    enWord.dispose();
    arWord.dispose();
    notes.dispose();
    super.onClose();
  }
}
