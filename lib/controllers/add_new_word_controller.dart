import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../utils/db_helper.dart';

class NewWordController extends GetxController {
  final enWord = TextEditingController();
  final arWord = TextEditingController();
  final notes = TextEditingController();
  final loading = false.obs;

  Future<bool> addNewWord() async {
    final english = enWord.text.trim();
    final arabic = arWord.text.trim();
    final description = notes.text.trim();

    if (english.isEmpty || arabic.isEmpty) {
      Get.snackbar('Missing word', 'English and Arabic words are required.');
      return false;
    }

    loading.value = true;
    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.insert(
        {
          DatabaseHelper.englishColumn: english,
          DatabaseHelper.arabicColumn: arabic,
          DatabaseHelper.descriptionColumn:
              description.isEmpty ? null : description,
          DatabaseHelper.favoriteColumn: 0,
          DatabaseHelper.dateColumn: DateTime.now().toIso8601String(),
        },
        DatabaseHelper.wordsTable,
      );
      return true;
    } catch (_) {
      Get.snackbar('Save failed', 'The word could not be saved.');
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
