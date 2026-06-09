import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_notifier.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

// استيراد المكونات المنفصلة الجديدة
import 'widgets/exercise_body.dart';
import 'widgets/exercise_hint_overlay.dart';

class ExerciseScreen extends ConsumerStatefulWidget {
  const ExerciseScreen({
    super.key,
    required this.sectionId,
    required this.modelId,
    required this.slug,
  });

  final int sectionId;
  final int modelId;
  final String slug;

  @override
  ConsumerState<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
  bool _showHintOverlay = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeExercise();
  }

  Future<void> _checkFirstTimeExercise() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTimeExercise') ?? true;
    if (isFirstTime) {
      setState(() {
        _showHintOverlay = true;
      });
    }
  }

  Future<void> _dismissHintOverlay() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTimeExercise', false);
    setState(() {
      _showHintOverlay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
        exerciseProvider((widget.sectionId, widget.modelId, widget.slug)));
    final notifier = ref.read(
        exerciseProvider((widget.sectionId, widget.modelId, widget.slug))
            .notifier);

    ref.listen(
        exerciseProvider((widget.sectionId, widget.modelId, widget.slug)),
        (prev, next) {
      if (next.isFinished && !(prev?.isFinished ?? false)) {
        Future.delayed(const Duration(milliseconds: 2400), () {
          if (context.mounted) {
            context.pushReplacement(
                '/results/${widget.sectionId}/${widget.modelId}?slug=${widget.slug}');
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          state.exercise.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(
              child: Text(err.toString(),
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.wrong)),
            ),
            data: (exercise) => ExerciseBody(
              exercise: exercise,
              state: state,
              notifier: notifier,
              sectionId: widget.sectionId,
              modelId: widget.modelId,
              slug: widget.slug,
            ),
          ),
          if (_showHintOverlay) ExerciseHintOverlay(onTap: _dismissHintOverlay),
        ],
      ),
    );
  }
}
