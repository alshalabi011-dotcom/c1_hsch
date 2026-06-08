import 'dart:convert';
import 'package:flutter/services.dart';
import '../domain/exercise.dart';
import '../../../../core/utils/result.dart';
import 'exercise_repository.dart';
import 'json_parser.dart';

/// Loads exercise JSON from assets, parses it, and caches per (sectionId, modelId).
/// Never throws to the UI — returns Result.err on any failure.
class ExerciseRepositoryImpl implements ExerciseRepository {
  final Map<String, Exercise> _cache = {};

  @override
  Future<Result<Exercise>> getExercise({
    required int sectionId,
    required int modelId,
    required String slug,
  }) async {
    final key = 's${sectionId}_m$modelId';
    if (_cache.containsKey(key)) return Result.ok(_cache[key]!);

    try {
      final path = 'assets/data/s${sectionId}_m${modelId}_$slug.json';
      final raw = await rootBundle.loadString(path);
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final exercise = JsonParser.parseExercise(json);
      _cache[key] = exercise;
      return Result.ok(exercise);
    } catch (e) {
      // Fallback: load section template from the same section folder, or from section1 if none exists.
      try {
        String raw;
        try {
          raw = await rootBundle
              .loadString('assets/data/s${sectionId}_m2_rechtschreibung.json');
        } catch (_) {
          raw = await rootBundle
              .loadString('assets/data/s1_m2_rechtschreibung.json');
        }
        final json = jsonDecode(raw) as Map<String, dynamic>;

        // Find model name from sections.json
        String modelName = slug;
        try {
          final sectionsRaw =
              await rootBundle.loadString('assets/data/sections.json');
          final sectionsJson = jsonDecode(sectionsRaw) as Map<String, dynamic>;
          final sections = sectionsJson['sections'] as List;
          final sec = sections.firstWhere((s) => s['id'] == sectionId);
          final models = sec['models'] as List;
          final mod = models.firstWhere((m) => m['id'] == modelId);
          modelName = mod['name'] as String;
        } catch (_) {}

        json['meta']['section'] = sectionId;
        json['meta']['model'] = modelId;
        json['meta']['model_name'] = modelName;

        final exercise = JsonParser.parseExercise(json);
        _cache[key] = exercise;
        return Result.ok(exercise);
      } catch (fallbackError) {
        return Result.err(
            'Failed to load exercise s${sectionId}_m$modelId: $e');
      }
    }
  }
}
