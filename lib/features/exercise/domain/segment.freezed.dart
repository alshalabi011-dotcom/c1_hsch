// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'segment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Segment {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String content) text,
    required TResult Function(String content) keyword,
    required TResult Function(int id) blank,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String content)? text,
    TResult? Function(String content)? keyword,
    TResult? Function(int id)? blank,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String content)? text,
    TResult Function(String content)? keyword,
    TResult Function(int id)? blank,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextSegment value) text,
    required TResult Function(KeywordSegment value) keyword,
    required TResult Function(BlankSegment value) blank,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextSegment value)? text,
    TResult? Function(KeywordSegment value)? keyword,
    TResult? Function(BlankSegment value)? blank,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextSegment value)? text,
    TResult Function(KeywordSegment value)? keyword,
    TResult Function(BlankSegment value)? blank,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SegmentCopyWith<$Res> {
  factory $SegmentCopyWith(Segment value, $Res Function(Segment) then) =
      _$SegmentCopyWithImpl<$Res, Segment>;
}

/// @nodoc
class _$SegmentCopyWithImpl<$Res, $Val extends Segment>
    implements $SegmentCopyWith<$Res> {
  _$SegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TextSegmentImplCopyWith<$Res> {
  factory _$$TextSegmentImplCopyWith(
          _$TextSegmentImpl value, $Res Function(_$TextSegmentImpl) then) =
      __$$TextSegmentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$TextSegmentImplCopyWithImpl<$Res>
    extends _$SegmentCopyWithImpl<$Res, _$TextSegmentImpl>
    implements _$$TextSegmentImplCopyWith<$Res> {
  __$$TextSegmentImplCopyWithImpl(
      _$TextSegmentImpl _value, $Res Function(_$TextSegmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$TextSegmentImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TextSegmentImpl implements TextSegment {
  const _$TextSegmentImpl({required this.content});

  @override
  final String content;

  @override
  String toString() {
    return 'Segment.text(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextSegmentImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextSegmentImplCopyWith<_$TextSegmentImpl> get copyWith =>
      __$$TextSegmentImplCopyWithImpl<_$TextSegmentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String content) text,
    required TResult Function(String content) keyword,
    required TResult Function(int id) blank,
  }) {
    return text(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String content)? text,
    TResult? Function(String content)? keyword,
    TResult? Function(int id)? blank,
  }) {
    return text?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String content)? text,
    TResult Function(String content)? keyword,
    TResult Function(int id)? blank,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextSegment value) text,
    required TResult Function(KeywordSegment value) keyword,
    required TResult Function(BlankSegment value) blank,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextSegment value)? text,
    TResult? Function(KeywordSegment value)? keyword,
    TResult? Function(BlankSegment value)? blank,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextSegment value)? text,
    TResult Function(KeywordSegment value)? keyword,
    TResult Function(BlankSegment value)? blank,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class TextSegment implements Segment {
  const factory TextSegment({required final String content}) =
      _$TextSegmentImpl;

  String get content;

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextSegmentImplCopyWith<_$TextSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$KeywordSegmentImplCopyWith<$Res> {
  factory _$$KeywordSegmentImplCopyWith(_$KeywordSegmentImpl value,
          $Res Function(_$KeywordSegmentImpl) then) =
      __$$KeywordSegmentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$KeywordSegmentImplCopyWithImpl<$Res>
    extends _$SegmentCopyWithImpl<$Res, _$KeywordSegmentImpl>
    implements _$$KeywordSegmentImplCopyWith<$Res> {
  __$$KeywordSegmentImplCopyWithImpl(
      _$KeywordSegmentImpl _value, $Res Function(_$KeywordSegmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$KeywordSegmentImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$KeywordSegmentImpl implements KeywordSegment {
  const _$KeywordSegmentImpl({required this.content});

  @override
  final String content;

  @override
  String toString() {
    return 'Segment.keyword(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeywordSegmentImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeywordSegmentImplCopyWith<_$KeywordSegmentImpl> get copyWith =>
      __$$KeywordSegmentImplCopyWithImpl<_$KeywordSegmentImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String content) text,
    required TResult Function(String content) keyword,
    required TResult Function(int id) blank,
  }) {
    return keyword(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String content)? text,
    TResult? Function(String content)? keyword,
    TResult? Function(int id)? blank,
  }) {
    return keyword?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String content)? text,
    TResult Function(String content)? keyword,
    TResult Function(int id)? blank,
    required TResult orElse(),
  }) {
    if (keyword != null) {
      return keyword(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextSegment value) text,
    required TResult Function(KeywordSegment value) keyword,
    required TResult Function(BlankSegment value) blank,
  }) {
    return keyword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextSegment value)? text,
    TResult? Function(KeywordSegment value)? keyword,
    TResult? Function(BlankSegment value)? blank,
  }) {
    return keyword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextSegment value)? text,
    TResult Function(KeywordSegment value)? keyword,
    TResult Function(BlankSegment value)? blank,
    required TResult orElse(),
  }) {
    if (keyword != null) {
      return keyword(this);
    }
    return orElse();
  }
}

abstract class KeywordSegment implements Segment {
  const factory KeywordSegment({required final String content}) =
      _$KeywordSegmentImpl;

  String get content;

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeywordSegmentImplCopyWith<_$KeywordSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlankSegmentImplCopyWith<$Res> {
  factory _$$BlankSegmentImplCopyWith(
          _$BlankSegmentImpl value, $Res Function(_$BlankSegmentImpl) then) =
      __$$BlankSegmentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$BlankSegmentImplCopyWithImpl<$Res>
    extends _$SegmentCopyWithImpl<$Res, _$BlankSegmentImpl>
    implements _$$BlankSegmentImplCopyWith<$Res> {
  __$$BlankSegmentImplCopyWithImpl(
      _$BlankSegmentImpl _value, $Res Function(_$BlankSegmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$BlankSegmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BlankSegmentImpl implements BlankSegment {
  const _$BlankSegmentImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'Segment.blank(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlankSegmentImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlankSegmentImplCopyWith<_$BlankSegmentImpl> get copyWith =>
      __$$BlankSegmentImplCopyWithImpl<_$BlankSegmentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String content) text,
    required TResult Function(String content) keyword,
    required TResult Function(int id) blank,
  }) {
    return blank(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String content)? text,
    TResult? Function(String content)? keyword,
    TResult? Function(int id)? blank,
  }) {
    return blank?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String content)? text,
    TResult Function(String content)? keyword,
    TResult Function(int id)? blank,
    required TResult orElse(),
  }) {
    if (blank != null) {
      return blank(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextSegment value) text,
    required TResult Function(KeywordSegment value) keyword,
    required TResult Function(BlankSegment value) blank,
  }) {
    return blank(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextSegment value)? text,
    TResult? Function(KeywordSegment value)? keyword,
    TResult? Function(BlankSegment value)? blank,
  }) {
    return blank?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextSegment value)? text,
    TResult Function(KeywordSegment value)? keyword,
    TResult Function(BlankSegment value)? blank,
    required TResult orElse(),
  }) {
    if (blank != null) {
      return blank(this);
    }
    return orElse();
  }
}

abstract class BlankSegment implements Segment {
  const factory BlankSegment({required final int id}) = _$BlankSegmentImpl;

  int get id;

  /// Create a copy of Segment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlankSegmentImplCopyWith<_$BlankSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
