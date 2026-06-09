import 'package:flutter/material.dart';
import '../../domain/option.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';

/// Modal bottom sheet for selecting an answer to a blank.
/// Spec §4.3 bottom sheet + spec §2.5 component styles.
class AnswerBottomSheet extends StatelessWidget {
  const AnswerBottomSheet({
    super.key,
    required this.blankId,
    required this.options,
    required this.usedKeys,
    required this.showTranslation,
    required this.onSelect,
  });

  final int blankId;
  final List<Option> options;

  /// Keys already committed to other blanks — excluded from list.
  final Set<String> usedKeys;
  final bool showTranslation;
  final void Function(String key) onSelect;

  @override
  Widget build(BuildContext context) {
    final available = options.where((o) => !usedKeys.contains(o.key)).toList();

    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SheetHandle(),
          _SheetHeader(blankId: blankId, onClose: () => Navigator.pop(context)),
          const Divider(height: 0),
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
              itemCount: available.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) => _OptionRow(
                option: available[index],
                showTranslation: showTranslation,
                onTap: () {
                  Navigator.pop(context);
                  onSelect(available[index].key);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Center(
        child: Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.blankId, required this.onClose});
  final int blankId;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.sheetTitle(blankId),
              style: AppTextStyles.headingMedium,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.textSecondary),
            onPressed: onClose,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.option,
    required this.showTranslation,
    required this.onTap,
  });

  final Option option;
  final bool showTranslation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LetterBadge(letter: option.key),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OptionText(text: option.de, keyword: option.keywords['de']),
                  if (showTranslation) ...[
                    const SizedBox(height: 4),
                    Text(
                      option.ar,
                      style: AppTextStyles.bodySmall,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 24×24 letter badge — spec §2.5.
class _LetterBadge extends StatelessWidget {
  const _LetterBadge({required this.letter});
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: AppTextStyles.labelMedium.copyWith(color: AppColors.accentDark),
      ),
    );
  }
}

/// Option sentence with inline keyword highlight.
class _OptionText extends StatelessWidget {
  const _OptionText({required this.text, this.keyword});
  final String text;
  final String? keyword;

  @override
  Widget build(BuildContext context) {
    if (keyword == null || keyword!.isEmpty || !text.contains(keyword!)) {
      return Text(text, style: AppTextStyles.bodyMedium);
    }

    final parts = text.split(keyword!);
    final spans = <InlineSpan>[];
    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i], style: AppTextStyles.bodyMedium));
      }
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: keyword,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w500,
          ),
        ));
      }
    }
    return Text.rich(TextSpan(children: spans));
  }
}
