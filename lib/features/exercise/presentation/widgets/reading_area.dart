import 'package:flutter/material.dart';
import '../../domain/segment.dart';
import '../../domain/option.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/blank_span.dart';
import '../../../../core/widgets/keyword_span.dart';

/// Builds the reading area for both DE and AR paragraphs.
/// German text is LTR tappable; Arabic text is RTL static markers.
class ReadingArea extends StatelessWidget {
  const ReadingArea({
    super.key,
    required this.paragraphs,
    required this.textDirection,
    required this.selectedAnswers,
    required this.activeBlankId,
    required this.optionsPool,
    this.onBlankTap, // null → static (AR paragraph)
  });

  final List<List<Segment>> paragraphs;
  final TextDirection textDirection;
  final Map<int, String> selectedAnswers;
  final int? activeBlankId;
  final List<Option> optionsPool;
  final void Function(int blankId)? onBlankTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: paragraphs
          .map((segments) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sectionGap),
                child: Text.rich(
                  TextSpan(
                    children: segments
                        .map((seg) => _buildSpan(context, seg))
                        .toList(),
                  ),
                  textDirection: textDirection,
                ),
              ))
          .toList(),
    );
  }

  InlineSpan _buildSpan(BuildContext context, Segment segment) {
    return switch (segment) {
      TextSegment(:final content) => TextSpan(
          text: content,
          style: AppTextStyles.bodyLarge,
        ),
      KeywordSegment(:final content) => WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: KeywordWidget(text: content),
        ),
      BlankSegment(:final id) => WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: _buildBlankWidget(id),
        ),
    };
  }

  Widget _buildBlankWidget(int id) {
    final chosen = selectedAnswers[id];
    final isActive = activeBlankId == id;

    BlankState blankState;
    String? displayText = chosen;

    if (onBlankTap == null) {
      // Static marker in Arabic paragraph
      blankState = chosen != null ? BlankState.correct : BlankState.unanswered;
    } else if (chosen != null) {
      // We need correctKey — passed via closure in ExerciseScreen
      blankState = BlankState.correct; // overridden in ExerciseScreen subclass
      displayText = chosen;
    } else if (isActive) {
      blankState = BlankState.active;
    } else {
      blankState = BlankState.unanswered;
    }

    return BlankWidget(
      blankId: id,
      blankState: blankState,
      displayText: displayText,
      onTap: (onBlankTap != null && id != 0) ? () => onBlankTap!(id) : null,
    );
  }
}

/// An enhanced version of [ReadingArea] that knows blank correctness.
class ReadingAreaWithCorrectness extends StatelessWidget {
  const ReadingAreaWithCorrectness({
    super.key,
    required this.paragraphs,
    required this.textDirection,
    required this.selectedAnswers,
    required this.activeBlankId,
    required this.correctKeys, // blankId → correctKey
    required this.optionsPool,
    this.onBlankTap,
  });

  final List<List<Segment>> paragraphs;
  final TextDirection textDirection;
  final Map<int, String> selectedAnswers;
  final int? activeBlankId;
  final Map<int, String> correctKeys;
  final List<Option> optionsPool;
  final void Function(int blankId)? onBlankTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: paragraphs
          .map((segments) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sectionGap),
                child: Text.rich(
                  TextSpan(
                    children: segments
                        .map((seg) => _buildSpan(context, seg))
                        .toList(),
                  ),
                  textDirection: textDirection,
                ),
              ))
          .toList(),
    );
  }

  InlineSpan _buildSpan(BuildContext context, Segment segment) {
    return switch (segment) {
      TextSegment(:final content) => TextSpan(
          text: content,
          style: AppTextStyles.bodyLarge,
        ),
      KeywordSegment(:final content) => WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: KeywordWidget(text: content),
        ),
      BlankSegment(:final id) => WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: _buildBlankWidget(id),
        ),
    };
  }

  Widget _buildBlankWidget(int id) {
    final chosen = selectedAnswers[id];
    final isActive = activeBlankId == id;

    BlankState blankState;

    if (chosen != null) {
      final correct = correctKeys[id];
      blankState = chosen == correct ? BlankState.correct : BlankState.wrong;
    } else if (isActive) {
      blankState = BlankState.active;
    } else {
      blankState = BlankState.unanswered;
    }

    return BlankWidget(
      blankId: id,
      blankState: blankState,
      displayText: chosen,
      onTap: (onBlankTap != null && id != 0) ? () => onBlankTap!(id) : null,
    );
  }
}
