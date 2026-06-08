import '../domain/exercise.dart';
import '../domain/segment.dart';
import '../domain/option.dart';
import '../domain/blank_answer.dart';

/// Parses a raw JSON map (from rootBundle) into an [Exercise] entity.
/// Pure Dart — no Flutter or async dependencies.
abstract final class JsonParser {
  static Exercise parseExercise(Map<String, dynamic> json) {
    final meta = json['meta'] as Map<String, dynamic>;
    final textData = json['text'] as Map<String, dynamic>;
    final answersData = json['answers'] as List<dynamic>;

    final deParagraphs = _parseParagraphs(textData['de'] as List<dynamic>);
    final arParagraphs = _parseParagraphs(textData['ar'] as List<dynamic>);

    // Options pool lives inside the first answer entry (id: 1) per spec §7.1
    final optionsPool = _parseOptionsPool(answersData);
    final blanks = _parseBlanks(answersData, optionsPool);

    return Exercise(
      sectionId: meta['section'] as int,
      modelId: meta['model'] as int,
      sectionName: meta['section_name'] as String,
      modelName: meta['model_name'] as String,
      totalBlanks: meta['total_blanks'] as int,
      deParagraphs: deParagraphs,
      arParagraphs: arParagraphs,
      blanks: blanks,
      optionsPool: optionsPool,
    );
  }

  static List<List<Segment>> _parseParagraphs(List<dynamic> paragraphs) {
    return paragraphs.map((p) {
      final segs = (p as Map<String, dynamic>)['segments'] as List<dynamic>;
      return segs.map(_parseSegment).toList();
    }).toList();
  }

  static Segment _parseSegment(dynamic raw) {
    final map = raw as Map<String, dynamic>;
    return switch (map['type'] as String) {
      'text' => Segment.text(content: map['content'] as String),
      'keyword' => Segment.keyword(content: map['content'] as String),
      'blank' => Segment.blank(id: map['id'] as int),
      _ => Segment.text(content: ''),
    };
  }

  static List<Option> _parseOptionsPool(List<dynamic> answers) {
    // Options live only under the first answer entry (blank id: 1)
    for (final answer in answers) {
      final map = answer as Map<String, dynamic>;
      if (map.containsKey('options')) {
        return (map['options'] as List)
            .map((o) => _parseOption(o as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  static Option _parseOption(Map<String, dynamic> map) {
    final keywords = map['keywords'] as Map<String, dynamic>? ?? {};
    return Option(
      key: map['key'] as String,
      de: map['de'] as String,
      ar: map['ar'] as String,
      keywords: keywords.map((k, v) => MapEntry(k, v as String)),
    );
  }

  static List<BlankAnswer> _parseBlanks(
      List<dynamic> answers, List<Option> optionsPool) {
    return answers.map((a) {
      final map = a as Map<String, dynamic>;
      return BlankAnswer(
        id: map['id'] as int,
        correctKey: map['correct_key'] as String,
        options: optionsPool,
      );
    }).toList();
  }
}
