import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_meta.freezed.dart';
part 'model_meta.g.dart';

/// Metadata for a single exercise model within a section.
/// Pure domain entity — no Flutter imports.
@freezed
class ModelMeta with _$ModelMeta {
  const factory ModelMeta({
    required int id,
    required String name,
    required String slug,
  }) = _ModelMeta;

  factory ModelMeta.fromJson(Map<String, dynamic> json) =>
      _$ModelMetaFromJson(json);
}
