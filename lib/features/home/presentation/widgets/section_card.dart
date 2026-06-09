import 'package:flutter/material.dart';
import '../../domain/section.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Redesigned premium card representation for each learning Section.
/// Features clean interactive hover effects and bilingual alignment.
class SectionCard extends StatefulWidget {
  const SectionCard({
    super.key,
    required this.section,
    required this.onTap,
  });

  final Section section;
  final VoidCallback onTap;

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isLocked = widget.section.isLocked;

    return Opacity(
      opacity: isLocked ? 0.5 : 1.0,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: _isHovered && !isLocked
                ? AppColors.surface
                : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border,
              width: 0.5,
            ),
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Left Side: Number Badge Circle
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isLocked
                          ? AppColors.background
                          : (_isHovered ? AppColors.accent : AppColors.surface),
                      shape: BoxShape.circle,
                      border: isLocked
                          ? Border.all(color: AppColors.border, width: 0.5)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.section.id.toString().padLeft(2, '0'),
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isLocked
                            ? AppColors.locked
                            : (_isHovered ? Colors.white : AppColors.accentDark),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Center: Titles (Bilingual)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.section.name,
                          style: AppTextStyles.headingMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.section.nameAr,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),

                  // Right Side: Progress Details & Action Icon
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isLocked
                              ? Colors.transparent
                              : AppColors.accentLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${widget.section.models.length} Modelle',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isLocked
                                ? AppColors.locked
                                : AppColors.accentDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isLocked ? Icons.lock : Icons.chevron_right,
                        color: isLocked ? AppColors.locked : AppColors.accent,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
