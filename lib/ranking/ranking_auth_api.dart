import 'package:firebase_auth/firebase_auth.dart';

class RankingAuthApi {
  Future<DateTime> getMyRankingJoinedTime() async {
    final user = FirebaseAuth.instance.currentUser;
    return user.metadata.creationTime;
  }
}
