import 'package:freezed_annotation/freezed_annotation.dart';

part 'segment.freezed.dart';

/// A single segment in a paragraph of the exercise text.
/// Pure domain — no Flutter imports.
@freezed
sealed class Segment with _$Segment {
  /// Plain text run
  const factory Segment.text({required String content}) = TextSegment;

  /// Highlighted keyword
  const factory Segment.keyword({required String content}) = KeywordSegment;

  /// A fill-in-the-blank
  const factory Segment.blank({required int id}) = BlankSegment;
}
