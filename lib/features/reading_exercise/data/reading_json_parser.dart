import '../domain/reading_exercise.dart';
import '../domain/reading_paragraph_model.dart';
import '../domain/reading_question.dart';

abstract final class ReadingJsonParser {
  static ReadingExercise parseReadingExercise(Map<String, dynamic> json) {
    final meta = json['meta'] as Map<String, dynamic>;
    final paragraphsData = json['paragraphs'] as List<dynamic>;
    final questionsData = json['questions'] as List<dynamic>;

    final paragraphs = paragraphsData.map((p) {
      final map = p as Map<String, dynamic>;
      return ReadingParagraphModel(
        letter: map['letter'] as String,
        de: map['de'] as String,
        ar: map['ar'] as String,
      );
    }).toList();

    final questions = questionsData.map((q) {
      final map = q as Map<String, dynamic>;
      return ReadingQuestion(
        number: map['number'] as String,
        de: map['de'] as String,
        ar: map['ar'] as String,
        correctAnswer: map['correct_answer'] as String,
      );
    }).toList();

    return ReadingExercise(
      sectionId: meta['section'] as int,
      modelId: meta['model'] as int,
      sectionName: meta['section_name'] as String,
      modelName: meta['model_name'] as String,
      level: meta['level'] as String,
      paragraphs: paragraphs,
      questions: questions,
    );
  }
}
