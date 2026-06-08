import 'package:freezed_annotation/freezed_annotation.dart';
import 'model_meta.dart';

part 'section.freezed.dart';
part 'section.g.dart';

/// A top-level section in the app (e.g. "LV1").
/// Pure domain entity — no Flutter imports.
@freezed
class Section with _$Section {
  const factory Section({
    required int id,
    required String name,
    required String nameAr,
    required bool isLocked,
    required List<ModelMeta> models,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}
