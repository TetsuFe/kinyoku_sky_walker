// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Memo _$_$_MemoFromJson(Map json) {
  return _$_Memo(
    body: json['body'] as String,
    calendarDate: json['calendarDate'] == null
        ? null
        : DateTime.parse(json['calendarDate'] as String),
  );
}

Map<String, dynamic> _$_$_MemoToJson(_$_Memo instance) => <String, dynamic>{
      'body': instance.body,
      'calendarDate': instance.calendarDate?.toIso8601String(),
    };
