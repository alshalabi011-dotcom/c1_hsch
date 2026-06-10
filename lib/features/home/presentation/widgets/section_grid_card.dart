import 'package:flutter/material.dart';
import '../../domain/section.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class SectionGridCard extends StatefulWidget {
  const SectionGridCard({
    super.key,
    required this.section,
    required this.onTap,
  });

  final Section section;
  final VoidCallback onTap;

  @override
  State<SectionGridCard> createState() => _SectionGridCardState();
}

class _SectionGridCardState extends State<SectionGridCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isLocked = widget.section.isLocked;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered && !isLocked ? -8 : 0, 0),
        decoration: BoxDecoration(
          color: isLocked
              ? AppColors.background
              : (_isHovered ? AppColors.surface : Theme.of(context).cardColor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered && !isLocked ? AppColors.accent : AppColors.border,
            width: _isHovered && !isLocked ? 1.5 : 0.5,
          ),
          boxShadow: _isHovered && !isLocked
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        child: Opacity(
          opacity: isLocked ? 0.6 : 1.0,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Number & Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: isLocked
                              ? AppColors.background
                              : (_isHovered ? AppColors.accent : AppColors.surface),
                          shape: BoxShape.circle,
                          border: isLocked ? Border.all(color: AppColors.border, width: 0.5) : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.section.id.toString().padLeft(2, '0'),
                          style: AppTextStyles.headingMedium.copyWith(
                            color: isLocked
                                ? AppColors.locked
                                : (_isHovered ? Colors.white : AppColors.accentDark),
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _isHovered && !isLocked
                              ? AppColors.accent.withValues(alpha: 0.1)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isLocked ? Icons.lock_outline : Icons.arrow_forward_rounded,
                          color: isLocked ? AppColors.locked : AppColors.accent,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  
                  // Bottom Section: Texts
                  Text(
                    widget.section.name,
                    style: AppTextStyles.headingMedium.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.section.nameAr,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  
                  // Progress/Models badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isLocked ? Colors.transparent : AppColors.accentLight,
                      borderRadius: BorderRadius.circular(10),
                      border: isLocked ? Border.all(color: AppColors.border) : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.grid_view_rounded,
                          size: 14,
                          color: isLocked ? AppColors.locked : AppColors.accentDark,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.section.models.length} Modelle',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isLocked ? AppColors.locked : AppColors.accentDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
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
