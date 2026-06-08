import 'dart:convert';
import 'package:flutter/services.dart';
import '../domain/section.dart';
import '../../../../core/utils/result.dart';
import 'section_repository.dart';

/// Loads sections.json from assets, parses it, and caches the result in memory.
/// Re-navigation never re-parses — spec §9 (repository caches on first load).
class SectionRepositoryImpl implements SectionRepository {
  List<Section>? _cache;

  @override
  Future<Result<List<Section>>> getSections() async {
    if (_cache != null) return Result.ok(_cache!);

    try {
      final raw = await rootBundle.loadString('assets/data/sections.json');
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final list = (json['sections'] as List)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList();
      _cache = list;
      return Result.ok(list);
    } catch (e) {
      return Result.err('Failed to load sections: $e');
    }
  }
}
