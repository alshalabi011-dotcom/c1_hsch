import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../home/presentation/sections_notifier.dart';
import 'results_retry_button.dart';

class ResultsActionButtons extends ConsumerWidget {
  const ResultsActionButtons({
    super.key,
    required this.onRetry,
    required this.sectionId,
    required this.modelId,
    required this.isReading,
  });

  final VoidCallback onRetry;
  final int sectionId;
  final int modelId;
  final bool isReading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsState = ref.watch(sectionsProvider);
    final sections = sectionsState.valueOrNull;

    dynamic nextModel;
    if (sections != null) {
      final currentSection = sections.where((s) => s.id == sectionId).firstOrNull;
      if (currentSection != null) {
        final currentIndex = currentSection.models.indexWhere((m) => m.id == modelId);
        if (currentIndex != -1 && currentIndex + 1 < currentSection.models.length) {
          nextModel = currentSection.models[currentIndex + 1];
        }
      }
    }

    final locale = ref.watch(localeProvider);
    final isGerman = locale.languageCode == 'de';
    String tr(String ar, String de) => isGerman ? de : ar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (nextModel != null) ...[
          FilledButton.icon(
            onPressed: () {
              final path = isReading ? '/reading_exercise' : '/exercise';
              context.pushReplacement('$path/$sectionId/${nextModel.id}?slug=${nextModel.slug}');
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.correct,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            icon: const Icon(Icons.skip_next_rounded, size: 20),
            label: Text(
              tr('الانتقال للنموذج التالي', 'Nächstes Modell'),
              style: AppTextStyles.labelMedium.copyWith(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        ResultsRetryButton(onPressed: onRetry),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            context.go('/sections');
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            side: BorderSide(color: AppColors.border),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.home_rounded, size: 20),
          label: Text(
            tr('العودة للصفحة الرئيسية', 'Zurück zur Startseite'),
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
