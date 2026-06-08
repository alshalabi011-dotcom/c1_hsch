import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/section_repository.dart';
import '../data/section_repository_impl.dart';
import '../domain/section.dart';

final sectionRepositoryProvider = Provider<SectionRepository>(
  (_) => SectionRepositoryImpl(),
);

/// Notifier that loads and exposes all sections.
class SectionsNotifier extends StateNotifier<AsyncValue<List<Section>>> {
  SectionsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadSections();
  }

  final SectionRepository _repository;

  Future<void> loadSections() async {
    state = const AsyncValue.loading();
    final result = await _repository.getSections();
    state = result.when(
      ok: (sections) => AsyncValue.data(sections),
      err: (message) => AsyncValue.error(message, StackTrace.empty),
    );
  }
}

final sectionsProvider =
    StateNotifierProvider<SectionsNotifier, AsyncValue<List<Section>>>(
  (ref) => SectionsNotifier(ref.read(sectionRepositoryProvider)),
);
