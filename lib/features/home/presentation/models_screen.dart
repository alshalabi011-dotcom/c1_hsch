import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/model_meta.dart';
import 'models_notifier.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';

/// الشاشة الرئيسية لعرض النماذج والدروس داخل قسم دراسي محدد.
class ModelsScreen extends ConsumerWidget {
  const ModelsScreen({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(modelsProvider(sectionId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          l10n.sectionNumber(sectionId),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(
            err.toString(),
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.wrong),
          ),
        ),
        data: (models) => _ModelsList(
          models: models,
          sectionId: sectionId,
        ),
      ),
    );
  }
}

class _ModelsList extends StatelessWidget {
  const _ModelsList({
    required this.models,
    required this.sectionId,
  });

  final List<ModelMeta> models;
  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: models.length + 1, // +1 من أجل رأس الشاشة التعريفي
      itemBuilder: (context, index) {
        if (index == 0) {
          // رأس الشاشة كعنصر أول داخل القائمة لكي يرتفع أثناء السحب بسلاسة
          return _SectionHeaderCard(sectionId: sectionId);
        }

        final modelIndex = index - 1;
        return _ModelCard(
          model: models[modelIndex],
          index: modelIndex,
          sectionId: sectionId,
          isFirst: modelIndex == 0,
        );
      },
    );
  }
}

class _SectionHeaderCard extends StatelessWidget {
  const _SectionHeaderCard({required this.sectionId});
  final int sectionId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.15),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.library_books_rounded,
                  color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.lerneinheitenTitle,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.modelsSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  const _ModelCard({
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () =>
            context.push('/exercise/$sectionId/${model.id}?slug=${model.slug}'),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              // رقم الدرس التوضيحي داخل مربع ناعم ملون
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // اسم ونص الدرس
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // العناصر البرمجية الإضافية (شارة جديد وسهم التنقل)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isFirst) ...[
                    const _NewBadge(),
                    const SizedBox(width: 8),
                  ],
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.accentDark.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Text(
        l10n.newBadge.toUpperCase(),
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.accentDark,
          fontWeight: FontWeight.bold,
          fontSize: 10,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
