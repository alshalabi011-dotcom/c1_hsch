import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/model_meta.dart';
import 'models_notifier.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

/// Screen showing all models within a section.
/// Spec §4.2.
class ModelsScreen extends ConsumerWidget {
  const ModelsScreen({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(modelsProvider(sectionId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Abschnitt $sectionId'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(err.toString(),
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.wrong)),
        ),
        data: (models) => ListView.separated(
          itemCount: models.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) => _ModelRow(
            model: models[index],
            index: index,
            sectionId: sectionId,
            isFirst: index == 0,
          ),
        ),
      ),
    );
  }
}

class _ModelRow extends StatelessWidget {
  const _ModelRow({
    required this.model,
    required this.index,
    required this.sectionId,
    required this.isFirst,
  });

  final ModelMeta model;
  final int index;
  final int sectionId;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/exercise/$sectionId/${model.id}?slug=${model.slug}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH,
          vertical: AppSpacing.cardV,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: Text(
                '${index + 1}',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(model.name, style: AppTextStyles.bodyLarge),
            ),
            if (isFirst)
              _NewBadge()
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'جديد',
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.accentDark,
          fontSize: 11,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
