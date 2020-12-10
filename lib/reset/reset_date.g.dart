// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResetDate _$_$_ResetDateFromJson(Map json) {
  return _$_ResetDate(
    userId: json['userId'] as String,
    resetDate: json['resetDate'] == null
        ? null
        : DateTime.parse(json['resetDate'] as String),
  );
}

Map<String, dynamic> _$_$_ResetDateToJson(_$_ResetDate instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'resetDate': instance.resetDate?.toIso8601String(),
    };
