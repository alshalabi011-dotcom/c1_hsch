import 'reading_paragraph_model.dart';
import 'reading_question.dart';

class ReadingExercise {
  final int sectionId;
  final int modelId;
  final String sectionName;
  final String modelName;
  final String level;
  final List<ReadingParagraphModel> paragraphs;
  final List<ReadingQuestion> questions;

  const ReadingExercise({
    required this.sectionId,
    required this.modelId,
    required this.sectionName,
    required this.modelName,
    required this.level,
    required this.paragraphs,
    required this.questions,
  });
}
