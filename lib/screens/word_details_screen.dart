import 'package:english_words_app/controllers/word_details_controller.dart';
import 'package:english_words_app/models/words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_word_screen.dart';

class WordDetailsScreen extends StatelessWidget {
  WordDetailsScreen({super.key});

  final WordDetailsController wordDetailsController =
      Get.put(WordDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDetailsController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              Get.back(result: controller.hasChanges);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Word Details'),
              leading: IconButton(
                onPressed: () {
                  Get.back(result: controller.hasChanges);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  tooltip: 'Delete',
                  onPressed: () {
                    _confirmDelete(context, controller);
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
                TextButton(
                  onPressed: () async {
                    final changed = await Get.to(
                      () => EditWordScreen(),
                      arguments: Word(
                        arWord: controller.arword,
                        date: controller.date,
                        description: controller.description,
                        enWord: controller.enword,
                        favorite: controller.favorite,
                        id: controller.id,
                      ),
                      transition: Transition.size,
                    );
                    if (changed == true) {
                      Get.back(result: true);
                    }
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _WordSection(
                  label: 'English',
                  value: controller.enword ?? '',
                  leading: IconButton(
                    tooltip: 'Listen to English',
                    onPressed: controller.speakEN,
                    icon: Icon(
                      controller.isPlaying ? Icons.stop : Icons.volume_up,
                    ),
                  ),
                  trailing: IconButton(
                    tooltip: 'Favourite',
                    onPressed: controller.addToFavorite,
                    icon: Icon(
                      controller.favorite == 1 ? Icons.star : Icons.star_border,
                      color: controller.favorite == 1
                          ? Theme.of(context).colorScheme.tertiary
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _WordSection(
                  label: 'Arabic',
                  value: controller.arword ?? '',
                  textDirection: TextDirection.rtl,
                  leading: IconButton(
                    tooltip: 'Listen to Arabic',
                    onPressed: controller.speakAR,
                    icon: Icon(
                      controller.isPlaying ? Icons.stop : Icons.volume_up,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          (controller.description?.trim().isNotEmpty ?? false)
                              ? controller.description!
                              : 'No notes added.',
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    WordDetailsController controller,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete word?'),
        content: const Text('This card will be removed from your list.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Get.back();
              await controller.deleteData();
              Get.back(result: true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _WordSection extends StatelessWidget {
  const _WordSection({
    required this.label,
    required this.value,
    required this.leading,
    this.trailing,
    this.textDirection,
  });

  final String label;
  final String value;
  final Widget leading;
  final Widget? trailing;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                ),
                const Spacer(),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                leading,
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value,
                    textDirection: textDirection,
                    textAlign: textDirection == TextDirection.rtl
                        ? TextAlign.end
                        : TextAlign.start,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
