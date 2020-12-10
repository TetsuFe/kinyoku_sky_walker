import 'package:cloud_firestore/cloud_firestore.dart';

class RankingSubInfoApi {
  final fs = FirebaseFirestore.instance;
  Future<int> fetchJoinRankUserNumber() async {
    final result = await fs
        .collection('joinRankUserNumber')
        .doc('joinRankUserNumber')
        .get();
    final data = result.data();
    return data['joinRankUserNumber'] as int;
  }
}
