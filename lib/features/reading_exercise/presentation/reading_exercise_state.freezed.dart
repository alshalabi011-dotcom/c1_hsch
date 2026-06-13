// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_exercise_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReadingExerciseState {
  AsyncValue<ReadingExercise> get exercise =>
      throw _privateConstructorUsedError;
  Map<String, String> get selectedAnswers => throw _privateConstructorUsedError;
  Map<String, bool> get validationResults => throw _privateConstructorUsedError;

  /// Create a copy of ReadingExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReadingExerciseStateCopyWith<ReadingExerciseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingExerciseStateCopyWith<$Res> {
  factory $ReadingExerciseStateCopyWith(ReadingExerciseState value,
          $Res Function(ReadingExerciseState) then) =
      _$ReadingExerciseStateCopyWithImpl<$Res, ReadingExerciseState>;
  @useResult
  $Res call(
      {AsyncValue<ReadingExercise> exercise,
      Map<String, String> selectedAnswers,
      Map<String, bool> validationResults});
}

/// @nodoc
class _$ReadingExerciseStateCopyWithImpl<$Res,
        $Val extends ReadingExerciseState>
    implements $ReadingExerciseStateCopyWith<$Res> {
  _$ReadingExerciseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReadingExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
    Object? selectedAnswers = null,
    Object? validationResults = null,
  }) {
    return _then(_value.copyWith(
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as AsyncValue<ReadingExercise>,
      selectedAnswers: null == selectedAnswers
          ? _value.selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      validationResults: null == validationResults
          ? _value.validationResults
          : validationResults // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadingExerciseStateImplCopyWith<$Res>
    implements $ReadingExerciseStateCopyWith<$Res> {
  factory _$$ReadingExerciseStateImplCopyWith(_$ReadingExerciseStateImpl value,
          $Res Function(_$ReadingExerciseStateImpl) then) =
      __$$ReadingExerciseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<ReadingExercise> exercise,
      Map<String, String> selectedAnswers,
      Map<String, bool> validationResults});
}

/// @nodoc
class __$$ReadingExerciseStateImplCopyWithImpl<$Res>
    extends _$ReadingExerciseStateCopyWithImpl<$Res, _$ReadingExerciseStateImpl>
    implements _$$ReadingExerciseStateImplCopyWith<$Res> {
  __$$ReadingExerciseStateImplCopyWithImpl(_$ReadingExerciseStateImpl _value,
      $Res Function(_$ReadingExerciseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReadingExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
    Object? selectedAnswers = null,
    Object? validationResults = null,
  }) {
    return _then(_$ReadingExerciseStateImpl(
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as AsyncValue<ReadingExercise>,
      selectedAnswers: null == selectedAnswers
          ? _value._selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      validationResults: null == validationResults
          ? _value._validationResults
          : validationResults // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc

class _$ReadingExerciseStateImpl implements _ReadingExerciseState {
  const _$ReadingExerciseStateImpl(
      {required this.exercise,
      final Map<String, String> selectedAnswers = const {},
      final Map<String, bool> validationResults = const {}})
      : _selectedAnswers = selectedAnswers,
        _validationResults = validationResults;

  @override
  final AsyncValue<ReadingExercise> exercise;
  final Map<String, String> _selectedAnswers;
  @override
  @JsonKey()
  Map<String, String> get selectedAnswers {
    if (_selectedAnswers is EqualUnmodifiableMapView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedAnswers);
  }

  final Map<String, bool> _validationResults;
  @override
  @JsonKey()
  Map<String, bool> get validationResults {
    if (_validationResults is EqualUnmodifiableMapView)
      return _validationResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_validationResults);
  }

  @override
  String toString() {
    return 'ReadingExerciseState(exercise: $exercise, selectedAnswers: $selectedAnswers, validationResults: $validationResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingExerciseStateImpl &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise) &&
            const DeepCollectionEquality()
                .equals(other._selectedAnswers, _selectedAnswers) &&
            const DeepCollectionEquality()
                .equals(other._validationResults, _validationResults));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      exercise,
      const DeepCollectionEquality().hash(_selectedAnswers),
      const DeepCollectionEquality().hash(_validationResults));

  /// Create a copy of ReadingExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingExerciseStateImplCopyWith<_$ReadingExerciseStateImpl>
      get copyWith =>
          __$$ReadingExerciseStateImplCopyWithImpl<_$ReadingExerciseStateImpl>(
              this, _$identity);
}

abstract class _ReadingExerciseState implements ReadingExerciseState {
  const factory _ReadingExerciseState(
      {required final AsyncValue<ReadingExercise> exercise,
      final Map<String, String> selectedAnswers,
      final Map<String, bool> validationResults}) = _$ReadingExerciseStateImpl;

  @override
  AsyncValue<ReadingExercise> get exercise;
  @override
  Map<String, String> get selectedAnswers;
  @override
  Map<String, bool> get validationResults;

  /// Create a copy of ReadingExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadingExerciseStateImplCopyWith<_$ReadingExerciseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
