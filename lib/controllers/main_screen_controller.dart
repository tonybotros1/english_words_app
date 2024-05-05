import 'package:english_words_app/utils/db_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  TextEditingController enword = TextEditingController();
  TextEditingController arword = TextEditingController();
  TextEditingController description = TextEditingController();
  var data = [].obs;
  List wordsCard = [];

  @override
  void onInit() {
    // deleteData(1);
    super.onInit();
    fetchData();
  }

  deleteData(id) async {
    var dbHelper = DatabaseHelper();
    await dbHelper.delete(id, 'wordsTable');
  }

  fetchData() async {
    var dbHelper = DatabaseHelper();
    data.value = await dbHelper.queryAllOrderBy('wordsTable');
    print(data);
  }
}
