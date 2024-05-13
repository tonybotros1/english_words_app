import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'dart:math';
import '../utils/db_helper.dart';

class QuizController extends GetxController {
  RxList data = [].obs;
  var random = Random();
  var quizWords;

  RxString enWordQuestion = RxString('');

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  fetchData() async {
    var dbHelper = DatabaseHelper();
    data.value = await dbHelper.queryAllOrderBy('wordsTable');

    var randomQuestionNumber = random.nextInt(data.length);
    quizWords = data[randomQuestionNumber];

    enWordQuestion.value = '${quizWords['enword']}';
  }
}
