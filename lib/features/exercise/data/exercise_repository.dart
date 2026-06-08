import '../domain/exercise.dart';
import '../../../../core/utils/result.dart';

/// Contract for loading a single exercise from assets.
abstract interface class ExerciseRepository {
  /// Returns the exercise for [sectionId] / [modelId].
  /// Slug is looked up from the sections manifest internally.
  /// Cached after first successful load.
  Future<Result<Exercise>> getExercise({
    required int sectionId,
    required int modelId,
    required String slug,
  });
}
