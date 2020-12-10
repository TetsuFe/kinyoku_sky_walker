// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Rank _$_$_RankFromJson(Map json) {
  return _$_Rank(
    userId: json['userId'] as String,
    rank: json['rank'] as int,
    topXPercent: (json['topXPercent'] as num)?.toDouble(),
    altRank: json['altRank'] as int,
    maxStoicTime: json['maxStoicTime'] as int,
  );
}

Map<String, dynamic> _$_$_RankToJson(_$_Rank instance) => <String, dynamic>{
      'userId': instance.userId,
      'rank': instance.rank,
      'topXPercent': instance.topXPercent,
      'altRank': instance.altRank,
      'maxStoicTime': instance.maxStoicTime,
    };
