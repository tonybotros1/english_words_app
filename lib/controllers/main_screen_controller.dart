import 'package:english_words_app/utils/db_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:async';


class MainScreenController extends GetxController {
  TextEditingController enword = TextEditingController();
  TextEditingController arword = TextEditingController();
  TextEditingController description = TextEditingController();
  var data = [].obs;
  List wordsCard = [];

  late Timer timer;

  RxBool showFilter = RxBool(false);

  final scrollOffset = 0.0.obs;
  final _opacity = 0.0.obs;
  double get opacity => _opacity.value;

  RxBool isInScreen = RxBool(true);

  @override
  void onInit() {
    ever(scrollOffset, (double offset) {
      if (offset > 0) {
        // Start animation when scrolling down
        _opacity.value = 1.0;
      } else {
        // Reverse animation when scrolling up
        _opacity.value = 0.0;
      }
    });
    // fetchData();
    timer = Timer.periodic(const Duration(seconds: 2), (_) => fetchData());
    super.onInit();
  }

  fetchData() async {
    var dbHelper = DatabaseHelper();
    data.value = await dbHelper.queryAllOrderBy('wordsTable');
    // print(data);
  }
}
