import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/reading_exercise.dart';
import 'reading_json_parser.dart';

final readingExerciseRepositoryProvider = Provider<ReadingExerciseRepository>((ref) {
  return ReadingExerciseRepository();
});

class ReadingExerciseRepository {
  Future<ReadingExercise> loadExercise(int sectionId, int modelId, String slug) async {
    try {
      final path = 'assets/data/section_$sectionId/s${sectionId}_m${modelId}_$slug.json';
      final jsonString = await rootBundle.loadString(path);
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return ReadingJsonParser.parseReadingExercise(jsonMap);
    } catch (e) {
      throw Exception('Failed to load reading exercise: $e');
    }
  }
}
