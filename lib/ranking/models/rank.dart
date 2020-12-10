import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'rank.freezed.dart';
part 'rank.g.dart';

class RankConverter implements JsonConverter<Rank, Map<String, dynamic>> {
  const RankConverter();

  @override
  Rank fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return _$_Rank(
      userId: json['userId'] as String,
      rank: json['rank'] as int,
      topXPercent: json['topXPercent'] as double,
      altRank: json['altRank'] as int,
      maxStoicTime: json['maxStoicTime'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(Rank data) => data.toJson();
}

@freezed
abstract class Rank with _$Rank {
  factory Rank({
    @required String userId,
    @required int rank,
    @required double topXPercent,
    @required int altRank,
    @required int maxStoicTime,
  }) = _Rank;

  factory Rank.fromJson(Map<String, dynamic> json) =>
      rankConverter.fromJson(json);

  static const rankConverter = RankConverter();
}
