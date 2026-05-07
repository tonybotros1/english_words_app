import 'package:english_words_app/models/words.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Word maps database columns to the app model', () {
    final word = Word.fromJson({
      'id': 1,
      'enword': 'book',
      'arword': 'kitab',
      'description': 'A thing you read',
      'date': '2026-05-07T10:00:00.000',
      'favorite': 1,
    });

    expect(word.id, 1);
    expect(word.enWord, 'book');
    expect(word.arWord, 'kitab');
    expect(word.description, 'A thing you read');
    expect(word.isFavorite, isTrue);
  });

  test('Word serializes using database column names', () {
    final word = Word(
      id: 2,
      enWord: 'water',
      arWord: 'maa',
      description: null,
      date: '2026-05-07T10:00:00.000',
      favorite: 0,
    );

    expect(word.toJson(), {
      'id': 2,
      'enword': 'water',
      'arword': 'maa',
      'description': null,
      'date': '2026-05-07T10:00:00.000',
      'favorite': 0,
    });
  });
}
