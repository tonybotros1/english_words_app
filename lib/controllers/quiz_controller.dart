import 'dart:math';

import 'package:get/get.dart';

import '../utils/db_helper.dart';

class QuizController extends GetxController {
  final data = <Map<String, dynamic>>[].obs;
  final options = <String>[].obs;
  final currentQuestion = Rxn<Map<String, dynamic>>();
  final selectedAnswer = RxnString();
  final answered = false.obs;
  final isLoading = true.obs;
  final score = 0.obs;
  final questionNumber = 0.obs;

  final _random = Random();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final dbHelper = DatabaseHelper();
    final rows = await dbHelper.queryAllOrderBy(DatabaseHelper.wordsTable);
    data.assignAll(rows);
    isLoading.value = false;

    if (data.isNotEmpty) {
      nextQuestion(resetScore: true);
    }
  }

  void nextQuestion({bool resetScore = false}) {
    if (data.isEmpty) {
      currentQuestion.value = null;
      options.clear();
      return;
    }

    if (resetScore) {
      score.value = 0;
      questionNumber.value = 0;
    }

    final question = data[_random.nextInt(data.length)];
    final correctAnswer =
        '${question[DatabaseHelper.arabicColumn] ?? ''}'.trim();

    final wrongAnswers = data
        .map((word) => '${word[DatabaseHelper.arabicColumn] ?? ''}'.trim())
        .where((answer) => answer.isNotEmpty && answer != correctAnswer)
        .toSet()
        .toList()
      ..shuffle(_random);

    final choices = <String>[
      correctAnswer,
      ...wrongAnswers.take(3),
    ]..shuffle(_random);

    currentQuestion.value = question;
    options.assignAll(choices);
    selectedAnswer.value = null;
    answered.value = false;
    questionNumber.value++;
  }

  void submitAnswer(String answer) {
    if (answered.value) {
      return;
    }

    selectedAnswer.value = answer;
    answered.value = true;

    if (answer == correctAnswer) {
      score.value++;
    }
  }

  String get englishQuestion {
    final question = currentQuestion.value;
    return '${question?[DatabaseHelper.englishColumn] ?? ''}';
  }

  String get correctAnswer {
    final question = currentQuestion.value;
    return '${question?[DatabaseHelper.arabicColumn] ?? ''}'.trim();
  }

  bool isCorrectAnswer(String answer) => answer == correctAnswer;
}
