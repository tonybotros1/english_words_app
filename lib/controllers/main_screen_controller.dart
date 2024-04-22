import 'package:english_words_app/utils/db_helper.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class MainScreenController extends GetxController {
  var data = [].obs; // Observable list to store data

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var dbHelper = DatabaseHelper();
    data.value = await dbHelper.queryAll('wordsTable');
  }

  void addData(Map<String, dynamic> newData) async {
    var dbHelper = DatabaseHelper();
    await dbHelper.insert(newData, 'wordsTable');
    fetchData(); // Refresh data after insertion
  }
}
