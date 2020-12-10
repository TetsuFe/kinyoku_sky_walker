import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/ranking/models/rank.dart';

final fs = FirebaseFirestore.instance;

class RankingApi {
  /*
  Future<bool> post({String username, String body}) async {
    try {
      await fb.firestore().collection('chat_messages').add(
              Map<String, dynamic>.from({
            'username': username,
            'body': body,
            'createdDate': FieldValue.serverTimestamp()
          }));
      return true;
    } on Exception catch (_) {
      // throw Exception('なんらかのエラーが発生しました');
      return false;
    }
  }
   */

  /*
  Future<Rank> initMyRank(String userId) async {
    final initialRank = Rank(
      userId: userId,
      maxStoicTime: 30,
      rank: 2,
    );
    try {
      fs.collection('ranks').doc(userId).set(initialRank.toJson());
    } on Exception catch (_) {
      throw Exception('なんらかのエラーが発生しました');
    }
    return initialRank;
  }
   */

  Future<Rank> getMyRank(String userId) async {
    print('getMyRank');
    try {
      final data = (await fs.collection('ranks').doc(userId).get()).data;
      print('getMyRank2');
      print(data());
      return Rank.fromJson(data());
    } on Exception catch (_) {
      throw Exception('なんらかのエラーが発生しました');
    }
  }

  Stream<List<Rank>> allRankSnapshot() {
    try {
      final data =
          fs.collection('ranks').snapshots().map((event) => event.docs.map((e) {
                return Rank.fromJson(e.data());
              }).toList());
      return data;
    } on Exception catch (_) {
      throw Exception('なんらかのエラーが発生しました');
    }
  }

  Future<List<Rank>> getMyUpperAndLower(String userId) async {
    try {
      final lastRankDoc = await fs
          .collection('ranks')
          .orderBy('rank', descending: true)
          .limit(1)
          .get();
      final lastRank = Rank.fromJson(lastRankDoc.docs.first.data());
      final rank = await getMyRank(userId);
      if (rank.altRank == lastRank.altRank) {
        final upperRankData = await fs
            .collection('ranks')
            .where('altRank', isEqualTo: rank.altRank - 1)
            .get();
        if (upperRankData.docs.isNotEmpty) {
          final upperRank = Rank.fromJson(upperRankData.docs.first.data());
          return [upperRank, rank];
        }
      }
      if (rank.altRank == 1) {
        final lowerRankData = await fs
            .collection('ranks')
            .where('altRank', isEqualTo: rank.altRank + 1)
            .get();
        if (lowerRankData.docs.isNotEmpty) {
          final lowerRank = Rank.fromJson(lowerRankData.docs.first.data());
          return [rank, lowerRank];
        }
      } else {
        Rank upperRank;
        Rank lowerRank;
        final upperRankData = await fs
            .collection('ranks')
            .where('altRank', isEqualTo: rank.altRank - 1)
            .get();
        if (upperRankData.docs.isNotEmpty) {
          print(upperRankData.docs.first.data());
          upperRank = Rank.fromJson(upperRankData.docs.first.data());
        }
        final lowerRankData = await fs
            .collection('ranks')
            .where('altRank', isEqualTo: rank.altRank + 1)
            .get();
        print(lowerRankData);
        if (lowerRankData.docs.isNotEmpty) {
          lowerRank = Rank.fromJson(lowerRankData.docs.first.data());
        }
        return [upperRank, rank, lowerRank].where((e) => e != null).toList();
      }
      print([rank]);
      return [rank];
    } on Exception catch (_) {
      print('error');
      throw Exception('なんらかのエラーが発生しました');
    }
  }
}

final rankingApiProvider = Provider(
  (ref) => RankingApi(),
);
