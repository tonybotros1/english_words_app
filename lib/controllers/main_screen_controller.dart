import 'package:english_words_app/utils/db_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:get/get_rx/get_rx.dart';

class MainScreenController extends GetxController {
  TextEditingController enword = TextEditingController();
  TextEditingController arword = TextEditingController();
  TextEditingController description = TextEditingController();
  var data = [].obs;
  List wordsCard = [];

  late Timer timer;

  RxBool isInScreen = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    fetchData();
    // timer = Timer.periodic(const Duration(seconds: 2), (_) => fetchData());
  }

  fetchData() async {
    var dbHelper = DatabaseHelper();
    data.value = await dbHelper.queryAllOrderBy('wordsTable');
    print(data);
    print('fffffffffffffffffffffffffff');
  }
}
