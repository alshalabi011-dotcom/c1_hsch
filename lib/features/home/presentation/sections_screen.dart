import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/section.dart';
import 'sections_notifier.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

/// Root screen showing all 8 sections.
/// Spec §4.1.
class SectionsScreen extends ConsumerWidget {
  const SectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sectionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('C1 Hsch'),
        centerTitle: false,
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(err.toString(),
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.wrong)),
        ),
        data: (sections) => ListView.separated(
          itemCount: sections.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) =>
              _SectionRow(section: sections[index]),
        ),
      ),
    );
  }
}

class _SectionRow extends ConsumerWidget {
  const _SectionRow({required this.section});
  final Section section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocked = section.isLocked;

    return Opacity(
      opacity: isLocked ? 1.0 : 1.0, // Full opacity — locked handled by color
      child: InkWell(
        onTap: isLocked
            ? () => _showLockedSnackbar(context)
            : () {
                context.push('/section/${section.id}');
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH,
            vertical: AppSpacing.cardV,
          ),
          child: Row(
            children: [
              _SectionCircle(number: section.id, isLocked: isLocked),
              const SizedBox(width: 12),
              Expanded(child: _SectionLabel(section: section)),
              _TrailingIcon(isLocked: isLocked),
            ],
          ),
        ),
      ),
    );
  }

  void _showLockedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'غير متاح بعد',
          textDirection: TextDirection.rtl,
          style: TextStyle(color: AppColors.textPrimary),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _SectionCircle extends StatelessWidget {
  const _SectionCircle({required this.number, required this.isLocked});
  final int number;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isLocked ? AppColors.surface : AppColors.accentLight,
        shape: BoxShape.circle,
        border: Border.all(
          color: isLocked ? AppColors.border : AppColors.accent,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '$number',
        style: AppTextStyles.labelMedium.copyWith(
          color: isLocked ? AppColors.locked : AppColors.accentDark,
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.section});
  final Section section;

  @override
  Widget build(BuildContext context) {
    final isLocked = section.isLocked;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: isLocked ? 0.4 : 1.0,
          child: Text(
            section.name,
            style: AppTextStyles.headingMedium,
          ),
        ),
        const SizedBox(height: 2),
        Opacity(
          opacity: isLocked ? 0.4 : 1.0,
          child: Text(
            '${section.models.length} نموذج',
            style: AppTextStyles.bodySmall,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}

class _TrailingIcon extends StatelessWidget {
  const _TrailingIcon({required this.isLocked});
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isLocked ? Icons.lock_outline : Icons.chevron_right,
      color: isLocked ? AppColors.locked : AppColors.textSecondary,
      size: 20,
    );
  }
}
