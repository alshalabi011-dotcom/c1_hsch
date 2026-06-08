import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/section_repository.dart';
import '../data/section_repository_impl.dart';
import '../domain/section.dart';
import '../domain/model_meta.dart';

final modelsRepositoryProvider = Provider<SectionRepository>(
  (_) => SectionRepositoryImpl(),
);

/// Notifier that loads models for a given section.
class ModelsNotifier extends StateNotifier<AsyncValue<List<ModelMeta>>> {
  ModelsNotifier(this._repository, this._sectionId)
      : super(const AsyncValue.loading()) {
    loadModels();
  }

  final SectionRepository _repository;
  final int _sectionId;

  Future<void> loadModels() async {
    state = const AsyncValue.loading();
    final result = await _repository.getSections();
    state = result.when(
      ok: (sections) {
        final section = sections.firstWhere(
          (s) => s.id == _sectionId,
          orElse: () => _emptySection,
        );
        return AsyncValue.data(section.models);
      },
      err: (message) => AsyncValue.error(message, StackTrace.empty),
    );
  }

  static final _emptySection = Section(
    id: 0,
    name: '',
    nameAr: '',
    isLocked: true,
    models: const [],
  );
}

final modelsProvider = StateNotifierProvider.family<ModelsNotifier,
    AsyncValue<List<ModelMeta>>, int>(
  (ref, sectionId) =>
      ModelsNotifier(ref.read(modelsRepositoryProvider), sectionId),
);
