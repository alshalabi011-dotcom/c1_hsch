// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExerciseState {
  AsyncValue<Exercise> get exercise => throw _privateConstructorUsedError;
  Map<int, String> get selectedAnswers =>
      throw _privateConstructorUsedError; // blankId → chosen key
  int? get activeBlankId => throw _privateConstructorUsedError;
  bool get showTranslation => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError; // 'de' | 'ar'
  bool get showFeedback => throw _privateConstructorUsedError;
  bool get lastAnswerCorrect => throw _privateConstructorUsedError;
  bool get isFinished => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseStateCopyWith<ExerciseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseStateCopyWith<$Res> {
  factory $ExerciseStateCopyWith(
          ExerciseState value, $Res Function(ExerciseState) then) =
      _$ExerciseStateCopyWithImpl<$Res, ExerciseState>;
  @useResult
  $Res call(
      {AsyncValue<Exercise> exercise,
      Map<int, String> selectedAnswers,
      int? activeBlankId,
      bool showTranslation,
      String lang,
      bool showFeedback,
      bool lastAnswerCorrect,
      bool isFinished});
}

/// @nodoc
class _$ExerciseStateCopyWithImpl<$Res, $Val extends ExerciseState>
    implements $ExerciseStateCopyWith<$Res> {
  _$ExerciseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
    Object? selectedAnswers = null,
    Object? activeBlankId = freezed,
    Object? showTranslation = null,
    Object? lang = null,
    Object? showFeedback = null,
    Object? lastAnswerCorrect = null,
    Object? isFinished = null,
  }) {
    return _then(_value.copyWith(
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Exercise>,
      selectedAnswers: null == selectedAnswers
          ? _value.selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as Map<int, String>,
      activeBlankId: freezed == activeBlankId
          ? _value.activeBlankId
          : activeBlankId // ignore: cast_nullable_to_non_nullable
              as int?,
      showTranslation: null == showTranslation
          ? _value.showTranslation
          : showTranslation // ignore: cast_nullable_to_non_nullable
              as bool,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      showFeedback: null == showFeedback
          ? _value.showFeedback
          : showFeedback // ignore: cast_nullable_to_non_nullable
              as bool,
      lastAnswerCorrect: null == lastAnswerCorrect
          ? _value.lastAnswerCorrect
          : lastAnswerCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseStateImplCopyWith<$Res>
    implements $ExerciseStateCopyWith<$Res> {
  factory _$$ExerciseStateImplCopyWith(
          _$ExerciseStateImpl value, $Res Function(_$ExerciseStateImpl) then) =
      __$$ExerciseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<Exercise> exercise,
      Map<int, String> selectedAnswers,
      int? activeBlankId,
      bool showTranslation,
      String lang,
      bool showFeedback,
      bool lastAnswerCorrect,
      bool isFinished});
}

/// @nodoc
class __$$ExerciseStateImplCopyWithImpl<$Res>
    extends _$ExerciseStateCopyWithImpl<$Res, _$ExerciseStateImpl>
    implements _$$ExerciseStateImplCopyWith<$Res> {
  __$$ExerciseStateImplCopyWithImpl(
      _$ExerciseStateImpl _value, $Res Function(_$ExerciseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
    Object? selectedAnswers = null,
    Object? activeBlankId = freezed,
    Object? showTranslation = null,
    Object? lang = null,
    Object? showFeedback = null,
    Object? lastAnswerCorrect = null,
    Object? isFinished = null,
  }) {
    return _then(_$ExerciseStateImpl(
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Exercise>,
      selectedAnswers: null == selectedAnswers
          ? _value._selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as Map<int, String>,
      activeBlankId: freezed == activeBlankId
          ? _value.activeBlankId
          : activeBlankId // ignore: cast_nullable_to_non_nullable
              as int?,
      showTranslation: null == showTranslation
          ? _value.showTranslation
          : showTranslation // ignore: cast_nullable_to_non_nullable
              as bool,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      showFeedback: null == showFeedback
          ? _value.showFeedback
          : showFeedback // ignore: cast_nullable_to_non_nullable
              as bool,
      lastAnswerCorrect: null == lastAnswerCorrect
          ? _value.lastAnswerCorrect
          : lastAnswerCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ExerciseStateImpl implements _ExerciseState {
  const _$ExerciseStateImpl(
      {required this.exercise,
      final Map<int, String> selectedAnswers = const {},
      this.activeBlankId,
      this.showTranslation = false,
      this.lang = 'de',
      this.showFeedback = false,
      this.lastAnswerCorrect = true,
      this.isFinished = false})
      : _selectedAnswers = selectedAnswers;

  @override
  final AsyncValue<Exercise> exercise;
  final Map<int, String> _selectedAnswers;
  @override
  @JsonKey()
  Map<int, String> get selectedAnswers {
    if (_selectedAnswers is EqualUnmodifiableMapView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedAnswers);
  }

// blankId → chosen key
  @override
  final int? activeBlankId;
  @override
  @JsonKey()
  final bool showTranslation;
  @override
  @JsonKey()
  final String lang;
// 'de' | 'ar'
  @override
  @JsonKey()
  final bool showFeedback;
  @override
  @JsonKey()
  final bool lastAnswerCorrect;
  @override
  @JsonKey()
  final bool isFinished;

  @override
  String toString() {
    return 'ExerciseState(exercise: $exercise, selectedAnswers: $selectedAnswers, activeBlankId: $activeBlankId, showTranslation: $showTranslation, lang: $lang, showFeedback: $showFeedback, lastAnswerCorrect: $lastAnswerCorrect, isFinished: $isFinished)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseStateImpl &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise) &&
            const DeepCollectionEquality()
                .equals(other._selectedAnswers, _selectedAnswers) &&
            (identical(other.activeBlankId, activeBlankId) ||
                other.activeBlankId == activeBlankId) &&
            (identical(other.showTranslation, showTranslation) ||
                other.showTranslation == showTranslation) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.showFeedback, showFeedback) ||
                other.showFeedback == showFeedback) &&
            (identical(other.lastAnswerCorrect, lastAnswerCorrect) ||
                other.lastAnswerCorrect == lastAnswerCorrect) &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      exercise,
      const DeepCollectionEquality().hash(_selectedAnswers),
      activeBlankId,
      showTranslation,
      lang,
      showFeedback,
      lastAnswerCorrect,
      isFinished);

  /// Create a copy of ExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseStateImplCopyWith<_$ExerciseStateImpl> get copyWith =>
      __$$ExerciseStateImplCopyWithImpl<_$ExerciseStateImpl>(this, _$identity);
}

abstract class _ExerciseState implements ExerciseState {
  const factory _ExerciseState(
      {required final AsyncValue<Exercise> exercise,
      final Map<int, String> selectedAnswers,
      final int? activeBlankId,
      final bool showTranslation,
      final String lang,
      final bool showFeedback,
      final bool lastAnswerCorrect,
      final bool isFinished}) = _$ExerciseStateImpl;

  @override
  AsyncValue<Exercise> get exercise;
  @override
  Map<int, String> get selectedAnswers; // blankId → chosen key
  @override
  int? get activeBlankId;
  @override
  bool get showTranslation;
  @override
  String get lang; // 'de' | 'ar'
  @override
  bool get showFeedback;
  @override
  bool get lastAnswerCorrect;
  @override
  bool get isFinished;

  /// Create a copy of ExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseStateImplCopyWith<_$ExerciseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
