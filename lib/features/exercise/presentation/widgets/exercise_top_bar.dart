import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ExerciseTopBar extends StatelessWidget {
  const ExerciseTopBar({
    super.key,
    required this.modelName,
    required this.answered,
    required this.total,
    required this.lang,
    required this.onBack,
    required this.onLangChanged,
  });

  final String modelName;
  final int answered;
  final int total;
  final String lang;
  final VoidCallback onBack;
  final void Function(String) onLangChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.background,
          border:
              Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: onBack,
              iconSize: 22,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                modelName,
                style: AppTextStyles.headingMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '$answered / $total',
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(width: 12),
            _LangToggle(lang: lang, onChanged: onLangChanged),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _LangToggle extends StatelessWidget {
  const _LangToggle({required this.lang, required this.onChanged});

  final String lang;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Segment(
              label: 'DE',
              isActive: lang == 'de',
              onTap: () => onChanged('de')),
          _Segment(
              label: 'AR',
              isActive: lang == 'ar',
              onTap: () => onChanged('ar')),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 32, minHeight: 28),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? AppColors.accentLight : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isActive ? AppColors.accentDark : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
