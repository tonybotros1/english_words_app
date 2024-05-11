import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/db_helper.dart';

class EditWordController extends GetxController {
  TextEditingController enWord = TextEditingController();
  TextEditingController arWord = TextEditingController();
  TextEditingController notes = TextEditingController();
  int? id;
  var loading = false;
  var data = [].obs;

  @override
  void onInit() async {
    await getData();

    super.onInit();
  }

  getData() {
    var arguments = Get.arguments;
    if (arguments != null) {
      enWord.text = arguments.enWord ?? '';
      arWord.text = arguments.arWord ?? '';
      notes.text = arguments.description ?? '';
      id = arguments.id;
    }
  }

  // this function to edit cards
  editCard(id) async {
    Map<String, dynamic> newData = {
      'arword': arWord.text,
      'enword': enWord.text,
      'description': notes.text,
    };
    var dbHelper = DatabaseHelper();
    await dbHelper.update('wordsTable', newData, 'id', id);
  }
}
