import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ReadingParagraph extends StatefulWidget {
  final String letter;
  final String content;
  final String translation;

  const ReadingParagraph({
    super.key,
    required this.letter,
    required this.content,
    required this.translation,
  });

  @override
  State<ReadingParagraph> createState() => _ReadingParagraphState();
}

class _ReadingParagraphState extends State<ReadingParagraph> {
  bool _showTranslation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
              left: 16.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.content,
                    style: AppTextStyles.bodyLarge,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  ),
                ),
                if (_showTranslation) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.translation,
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textSecondary),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _showTranslation = !_showTranslation;
                      });
                    },
                    icon: Icon(
                      _showTranslation
                          ? Icons.translate_outlined
                          : Icons.translate,
                      size: 16,
                      color: AppColors.accent,
                    ),
                    label: Text(
                      _showTranslation ? 'إخفاء الترجمة' : 'انقر للترجمة',
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.accent),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -12,
            left: 16,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
                border:
                    Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
              ),
              child: Center(
                child: Text(
                  widget.letter,
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
