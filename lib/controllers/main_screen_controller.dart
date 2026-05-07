import 'package:english_words_app/utils/db_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainScreenController extends GetxController {
  final allData = <Map<String, dynamic>>[].obs;
  final favData = <Map<String, dynamic>>[].obs;
  final selectedFilter = 'All'.obs;
  final searchText = ''.obs;
  final searchController = TextEditingController();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final dbHelper = DatabaseHelper();
    final rows = await dbHelper.queryAllOrderBy(DatabaseHelper.wordsTable);
    allData.assignAll(rows);
    favData.assignAll(
      rows.where((word) => word[DatabaseHelper.favoriteColumn] == 1),
    );
    isLoading.value = false;
  }

  void setFilter(String value) {
    selectedFilter.value = value;
  }

  void setSearchText(String value) {
    searchText.value = value;
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
  }

  List<Map<String, dynamic>> get visibleData {
    final source = selectedFilter.value == 'Favourites' ? favData : allData;
    final query = searchText.value.trim().toLowerCase();

    if (query.isEmpty) {
      return List<Map<String, dynamic>>.from(source);
    }

    return source.where((word) {
      final english =
          '${word[DatabaseHelper.englishColumn] ?? ''}'.toLowerCase();
      final arabic = '${word[DatabaseHelper.arabicColumn] ?? ''}'.toLowerCase();
      final description =
          '${word[DatabaseHelper.descriptionColumn] ?? ''}'.toLowerCase();
      return english.contains(query) ||
          arabic.contains(query) ||
          description.contains(query);
    }).toList();
  }

  String formatDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '';
    }

    final date = DateTime.tryParse(value);
    if (date == null) {
      return value;
    }

    return DateFormat.yMMMd().format(date);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
