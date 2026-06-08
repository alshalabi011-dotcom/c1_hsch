// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModelMetaImpl _$$ModelMetaImplFromJson(Map<String, dynamic> json) =>
    _$ModelMetaImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$$ModelMetaImplToJson(_$ModelMetaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
