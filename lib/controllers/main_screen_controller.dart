import 'package:english_words_app/models/words.dart';
import 'package:english_words_app/utils/db_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class MainScreenController extends GetxController {
  TextEditingController enword = TextEditingController();
  TextEditingController arword = TextEditingController();
  TextEditingController description = TextEditingController();
  
}
