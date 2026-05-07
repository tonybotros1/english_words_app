import 'package:english_words_app/consts.dart';
import 'package:english_words_app/models/words.dart';
import 'package:english_words_app/screens/add_new_word_screen.dart';
import 'package:english_words_app/screens/quiz_screen.dart';
import 'package:english_words_app/screens/settings_screen.dart';
import 'package:english_words_app/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_screen_controller.dart';
import 'word_details_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainScreenController mainScreenController =
      Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'Quiz') {
                await Get.to(() => const QuizScreen());
                await mainScreenController.fetchData();
              }
              if (value == 'Settings') {
                await Get.to(() => const SettingsScreen());
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: 'Quiz',
                  child: ListTile(
                    leading: Icon(Icons.quiz_outlined),
                    title: Text('Quiz'),
                  ),
                ),
                PopupMenuItem(
                  value: 'Settings',
                  child: ListTile(
                    leading: Icon(Icons.settings_outlined),
                    title: Text('Settings'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final changed = await Get.to(() => NewWordScreen());
          if (changed == true) {
            await mainScreenController.fetchData();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (mainScreenController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final words = mainScreenController.visibleData;
        final showEmpty = words.isEmpty;

        return RefreshIndicator(
          onRefresh: mainScreenController.fetchData,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: mainScreenController.searchController,
                        onChanged: mainScreenController.setSearchText,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Search words or notes',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: mainScreenController
                                  .searchText.value.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: mainScreenController.clearSearch,
                                  icon: const Icon(Icons.close),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: Text(
                              'All (${mainScreenController.allData.length})',
                            ),
                            selected:
                                mainScreenController.selectedFilter.value ==
                                    'All',
                            onSelected: (_) {
                              mainScreenController.setFilter('All');
                            },
                          ),
                          ChoiceChip(
                            label: Text(
                              'Favourites (${mainScreenController.favData.length})',
                            ),
                            selected:
                                mainScreenController.selectedFilter.value ==
                                    'Favourites',
                            onSelected: (_) {
                              mainScreenController.setFilter('Favourites');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (showEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyState(
                    isFiltering: mainScreenController.searchText.value
                            .trim()
                            .isNotEmpty ||
                        mainScreenController.selectedFilter.value != 'All',
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
                  sliver: SliverList.separated(
                    itemCount: words.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final word = words[index];
                      return _WordCard(
                        word: word,
                        date: mainScreenController.formatDate(
                          '${word[DatabaseHelper.dateColumn] ?? ''}',
                        ),
                        onTap: () async {
                          final changed = await Get.to(
                            () => WordDetailsScreen(),
                            arguments: Word.fromJson(word),
                            transition: Transition.size,
                          );
                          if (changed == true) {
                            await mainScreenController.fetchData();
                          }
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _WordCard extends StatelessWidget {
  const _WordCard({
    required this.word,
    required this.date,
    required this.onTap,
  });

  final Map<String, dynamic> word;
  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isFavorite = word[DatabaseHelper.favoriteColumn] == 1;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${word[DatabaseHelper.englishColumn] ?? ''}',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (isFavorite)
                    Icon(Icons.star, color: colorScheme.tertiary, size: 28),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      date,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${word[DatabaseHelper.arabicColumn] ?? ''}',
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.isFiltering});

  final bool isFiltering;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/cat.png',
              width: 160,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 24),
            Text(
              isFiltering ? 'No matching words' : 'No cards yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              isFiltering
                  ? 'Try a different search or switch back to All.'
                  : 'Tap + to add your first English word.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
