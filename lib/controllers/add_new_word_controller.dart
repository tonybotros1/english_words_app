import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../utils/db_helper.dart';

class NewWordController extends GetxController {
  TextEditingController enWord = TextEditingController();
  TextEditingController arWord = TextEditingController();
  TextEditingController notes = TextEditingController();
  var loading = false;
  var data = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var dbHelper = DatabaseHelper();
    data.value = await dbHelper.queryAll('wordsTable');
    print(data);
  }

  addData(Map<String, dynamic> newData) async {
    var dbHelper = DatabaseHelper();
    await dbHelper.insert(newData, 'wordsTable');
    fetchData(); // Refresh data after insertion
  }

  addNewWord() async {
    loading = true;
    var word = {
      'enWord': enWord.text,
      'arWord': arWord.text,
      'description': notes.text.isEmpty ? null : notes.text,
      'favorite': false,
      'date': DateTime.now().toString(),
    };

    await addData(word);
    loading = false;
    update();
  }
}
