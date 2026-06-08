import 'package:freezed_annotation/freezed_annotation.dart';
import 'segment.dart';
import 'blank_answer.dart';
import 'option.dart';

part 'exercise.freezed.dart';

/// Top-level exercise entity holding all paragraphs and answer data.
/// Pure domain — no Flutter imports.
@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required int sectionId,
    required int modelId,
    required String sectionName,
    required String modelName,
    required int totalBlanks,
    required List<List<Segment>> deParagraphs,
    required List<List<Segment>> arParagraphs,
    required List<BlankAnswer> blanks,
    required List<Option> optionsPool,
  }) = _Exercise;
}
