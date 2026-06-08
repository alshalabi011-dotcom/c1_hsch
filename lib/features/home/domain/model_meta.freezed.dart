// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ModelMeta _$ModelMetaFromJson(Map<String, dynamic> json) {
  return _ModelMeta.fromJson(json);
}

/// @nodoc
mixin _$ModelMeta {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;

  /// Serializes this ModelMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModelMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelMetaCopyWith<ModelMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelMetaCopyWith<$Res> {
  factory $ModelMetaCopyWith(ModelMeta value, $Res Function(ModelMeta) then) =
      _$ModelMetaCopyWithImpl<$Res, ModelMeta>;
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class _$ModelMetaCopyWithImpl<$Res, $Val extends ModelMeta>
    implements $ModelMetaCopyWith<$Res> {
  _$ModelMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelMetaImplCopyWith<$Res>
    implements $ModelMetaCopyWith<$Res> {
  factory _$$ModelMetaImplCopyWith(
          _$ModelMetaImpl value, $Res Function(_$ModelMetaImpl) then) =
      __$$ModelMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class __$$ModelMetaImplCopyWithImpl<$Res>
    extends _$ModelMetaCopyWithImpl<$Res, _$ModelMetaImpl>
    implements _$$ModelMetaImplCopyWith<$Res> {
  __$$ModelMetaImplCopyWithImpl(
      _$ModelMetaImpl _value, $Res Function(_$ModelMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModelMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(_$ModelMetaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelMetaImpl implements _ModelMeta {
  const _$ModelMetaImpl(
      {required this.id, required this.name, required this.slug});

  factory _$ModelMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelMetaImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;

  @override
  String toString() {
    return 'ModelMeta(id: $id, name: $name, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelMetaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  /// Create a copy of ModelMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelMetaImplCopyWith<_$ModelMetaImpl> get copyWith =>
      __$$ModelMetaImplCopyWithImpl<_$ModelMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelMetaImplToJson(
      this,
    );
  }
}

abstract class _ModelMeta implements ModelMeta {
  const factory _ModelMeta(
      {required final int id,
      required final String name,
      required final String slug}) = _$ModelMetaImpl;

  factory _ModelMeta.fromJson(Map<String, dynamic> json) =
      _$ModelMetaImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get slug;

  /// Create a copy of ModelMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelMetaImplCopyWith<_$ModelMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
