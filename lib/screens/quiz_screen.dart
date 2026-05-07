import 'package:english_words_app/screens/add_new_word_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.put(QuizController());

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.data.isEmpty) {
          return _EmptyQuiz(onAddWord: () async {
            final changed = await Get.to(() => NewWordScreen());
            if (changed == true) {
              await controller.fetchData();
            }
          });
        }

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Text(
                  'Question ${controller.questionNumber.value}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const Spacer(),
                Chip(
                  avatar: const Icon(Icons.check, size: 18),
                  label: Text('Score ${controller.score.value}'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose the Arabic meaning for',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.englishQuestion,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    if (controller.data.length == 1) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Add more words to make this quiz harder.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...controller.options.map((answer) {
              final selected = controller.selectedAnswer.value == answer;
              final answered = controller.answered.value;
              final correct = controller.isCorrectAnswer(answer);
              Color? tileColor;
              IconData? icon;

              if (answered && correct) {
                tileColor = Theme.of(context).colorScheme.primaryContainer;
                icon = Icons.check_circle;
              } else if (answered && selected) {
                tileColor = Theme.of(context).colorScheme.errorContainer;
                icon = Icons.cancel;
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  color: tileColor,
                  child: ListTile(
                    onTap: answered
                        ? null
                        : () {
                            controller.submitAnswer(answer);
                          },
                    title: Text(
                      answer,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.end,
                    ),
                    trailing: icon == null ? null : Icon(icon),
                  ),
                ),
              );
            }),
            if (controller.answered.value) ...[
              const SizedBox(height: 10),
              Text(
                controller.selectedAnswer.value == controller.correctAnswer
                    ? 'Correct!'
                    : 'Correct answer: ${controller.correctAnswer}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  controller.nextQuestion();
                },
                icon: const Icon(Icons.navigate_next),
                label: const Text('Next question'),
              ),
            ],
          ],
        );
      }),
    );
  }
}

class _EmptyQuiz extends StatelessWidget {
  const _EmptyQuiz({required this.onAddWord});

  final VoidCallback onAddWord;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.quiz_outlined,
              size: 72,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'No words to quiz yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add a few cards, then come back here to test your memory.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAddWord,
              icon: const Icon(Icons.add),
              label: const Text('Add word'),
            ),
          ],
        ),
      ),
    );
  }
}
