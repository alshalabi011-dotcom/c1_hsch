import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ReadingQuestionCard extends StatefulWidget {
  final String number;
  final String questionDe;
  final String questionAr;
  final String? selectedLetter;
  final bool? isCorrect;
  final ValueChanged<String> onAnswerSelected;

  const ReadingQuestionCard({
    super.key,
    required this.number,
    required this.questionDe,
    required this.questionAr,
    required this.selectedLetter,
    required this.isCorrect,
    required this.onAnswerSelected,
  });

  @override
  State<ReadingQuestionCard> createState() => _ReadingQuestionCardState();
}

class _ReadingQuestionCardState extends State<ReadingQuestionCard> {
  bool _showTranslation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.number}. ',
                style: AppTextStyles.headingMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  widget.questionDe,
                  style: AppTextStyles.headingMedium,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          if (_showTranslation) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.questionAr,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
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
                _showTranslation ? Icons.translate_outlined : Icons.translate,
                size: 16,
                color: AppColors.accent,
              ),
              label: Text(
                _showTranslation ? 'إخفاء الترجمة' : 'انقر للترجمة',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.accent),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['a', 'b', 'c', 'd', 'e'].map((letter) {
              final isSelected = widget.selectedLetter == letter;
              Color bgColor = AppColors.background;
              Color borderColor = AppColors.border.withValues(alpha: 0.8);
              Color textColor = AppColors.textPrimary;

              if (isSelected) {
                if (widget.isCorrect == true) {
                  bgColor = AppColors.correct.withValues(alpha: 0.2);
                  borderColor = AppColors.correct;
                  textColor = AppColors.correct;
                } else if (widget.isCorrect == false) {
                  bgColor = AppColors.wrong.withValues(alpha: 0.2);
                  borderColor = AppColors.wrong;
                  textColor = AppColors.wrong;
                }
              }

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: letter != 'e' ? 8.0 : 0,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (widget.selectedLetter == null || widget.isCorrect == false) {
                        widget.onAnswerSelected(letter);
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: borderColor),
                        boxShadow: [
                          if (!isSelected)
                            BoxShadow(
                              color: AppColors.border.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        letter,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
