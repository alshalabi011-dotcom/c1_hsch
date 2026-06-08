import 'package:freezed_annotation/freezed_annotation.dart';

part 'option.freezed.dart';
part 'option.g.dart';

/// One answer option in the bottom sheet option list.
/// Pure domain — no Flutter imports.
@freezed
class Option with _$Option {
  const factory Option({
    required String key,
    required String de,
    required String ar,
    @Default({}) Map<String, String> keywords,
  }) = _Option;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}
