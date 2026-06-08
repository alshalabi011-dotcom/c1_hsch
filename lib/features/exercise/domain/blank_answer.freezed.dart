// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blank_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BlankAnswer {
  int get id => throw _privateConstructorUsedError;
  String get correctKey => throw _privateConstructorUsedError;
  List<Option> get options => throw _privateConstructorUsedError;

  /// Create a copy of BlankAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlankAnswerCopyWith<BlankAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlankAnswerCopyWith<$Res> {
  factory $BlankAnswerCopyWith(
          BlankAnswer value, $Res Function(BlankAnswer) then) =
      _$BlankAnswerCopyWithImpl<$Res, BlankAnswer>;
  @useResult
  $Res call({int id, String correctKey, List<Option> options});
}

/// @nodoc
class _$BlankAnswerCopyWithImpl<$Res, $Val extends BlankAnswer>
    implements $BlankAnswerCopyWith<$Res> {
  _$BlankAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlankAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? correctKey = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      correctKey: null == correctKey
          ? _value.correctKey
          : correctKey // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlankAnswerImplCopyWith<$Res>
    implements $BlankAnswerCopyWith<$Res> {
  factory _$$BlankAnswerImplCopyWith(
          _$BlankAnswerImpl value, $Res Function(_$BlankAnswerImpl) then) =
      __$$BlankAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String correctKey, List<Option> options});
}

/// @nodoc
class __$$BlankAnswerImplCopyWithImpl<$Res>
    extends _$BlankAnswerCopyWithImpl<$Res, _$BlankAnswerImpl>
    implements _$$BlankAnswerImplCopyWith<$Res> {
  __$$BlankAnswerImplCopyWithImpl(
      _$BlankAnswerImpl _value, $Res Function(_$BlankAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of BlankAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? correctKey = null,
    Object? options = null,
  }) {
    return _then(_$BlankAnswerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      correctKey: null == correctKey
          ? _value.correctKey
          : correctKey // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>,
    ));
  }
}

/// @nodoc

class _$BlankAnswerImpl implements _BlankAnswer {
  const _$BlankAnswerImpl(
      {required this.id,
      required this.correctKey,
      final List<Option> options = const []})
      : _options = options;

  @override
  final int id;
  @override
  final String correctKey;
  final List<Option> _options;
  @override
  @JsonKey()
  List<Option> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'BlankAnswer(id: $id, correctKey: $correctKey, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlankAnswerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.correctKey, correctKey) ||
                other.correctKey == correctKey) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, correctKey,
      const DeepCollectionEquality().hash(_options));

  /// Create a copy of BlankAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlankAnswerImplCopyWith<_$BlankAnswerImpl> get copyWith =>
      __$$BlankAnswerImplCopyWithImpl<_$BlankAnswerImpl>(this, _$identity);
}

abstract class _BlankAnswer implements BlankAnswer {
  const factory _BlankAnswer(
      {required final int id,
      required final String correctKey,
      final List<Option> options}) = _$BlankAnswerImpl;

  @override
  int get id;
  @override
  String get correctKey;
  @override
  List<Option> get options;

  /// Create a copy of BlankAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlankAnswerImplCopyWith<_$BlankAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
