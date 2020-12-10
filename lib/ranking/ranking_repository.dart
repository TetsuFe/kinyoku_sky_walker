import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/ranking/ranking_sub_info_api.dart';
import 'package:meta/meta.dart';

import 'models/rank.dart';
import 'ranking_api.dart';

class RankingRepository {
  RankingRepository({@required this.rankingApi});
  final RankingApi rankingApi;

  Stream<List<Rank>> getAll() {
    return rankingApi.allRankSnapshot();
  }

  Future<Rank> getMyRank(String userId) {
    return rankingApi.getMyRank(userId);
  }

  Future<List<Rank>> getMyLowerAndUpper(String userId) {
    return rankingApi.getMyUpperAndLower(userId);
  }

  Future<int> fetchJoinRankUserNumber() {
    return RankingSubInfoApi().fetchJoinRankUserNumber();
  }
}

final rankingRepositoryProvider = Provider(
    (ref) => RankingRepository(rankingApi: ref.read(rankingApiProvider)));
