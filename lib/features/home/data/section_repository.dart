import '../domain/section.dart';
import '../../../../core/utils/result.dart';

/// Contract for loading section and model metadata.
abstract interface class SectionRepository {
  /// Returns the full list of sections (with nested models).
  /// Cached after first successful load.
  Future<Result<List<Section>>> getSections();
}
