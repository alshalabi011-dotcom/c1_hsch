import 'package:freezed_annotation/freezed_annotation.dart';
import 'option.dart';

part 'blank_answer.freezed.dart';

/// Represents one blank's answer data: its ID, the correct key, and
/// the shared options pool (extracted from blank id:1 in the JSON).
/// Pure domain — no Flutter imports.
@freezed
class BlankAnswer with _$BlankAnswer {
  const factory BlankAnswer({
    required int id,
    required String correctKey,
    @Default([]) List<Option> options,
  }) = _BlankAnswer;
}
