// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
      key: json['key'] as String,
      de: json['de'] as String,
      ar: json['ar'] as String,
      keywords: (json['keywords'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'de': instance.de,
      'ar': instance.ar,
      'keywords': instance.keywords,
    };
