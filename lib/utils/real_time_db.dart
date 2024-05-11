import 'dart:async';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends GetxService {
  final Database db;
  final _dataStream = Rx<List<Map<String, dynamic>>>([]);

  // Stream getter
  Stream<List<Map<String, dynamic>>> get dataStream => _dataStream.stream;

  DatabaseService(this.db) {
    // Listen for database changes
    _listenForDatabaseChanges();
  }

  // Function to listen for database changes
  void _listenForDatabaseChanges() {
    // You need to implement your database logic here to listen for changes
    // For example, you can listen for changes using database triggers or polling the database periodically
    // Whenever there's a change in the database, emit new data to the stream
    // For demonstration purposes, you can emit sample data every 5 seconds
    Timer.periodic(Duration(seconds: 5), (timer) async {
      List<Map<String, dynamic>> newData = await db.query('your_table');
      _dataStream.value = newData;
    });
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize the stream when the service is initialized
    _listenForDatabaseChanges();
  }

  @override
  void onClose() {
    super.onClose();
    // Close the stream when the service is closed
    _dataStream.close();
  }
}
