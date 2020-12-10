import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/auth/auth_facade.dart';
import 'package:kinyoku_continue/reset/reset_date.dart';
import 'package:meta/meta.dart';

final firestore = FirebaseFirestore.instance;

class ResetApi {
  ResetApi({@required this.authFacade});

  final AuthFacade authFacade;

  Future<void> saveResetDate(DateTime resetDate) async {
    final user = await authFacade.signIn();
    firestore.collection('resetDates').add(
        ResetDate(userId: user.getId(), resetDate: resetDate).toDateJson());
  }
}

final resetApiProvider =
    Provider((ref) => ResetApi(authFacade: ref.read(authFacadeProvider)));
