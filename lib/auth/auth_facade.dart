import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_api.dart';
import 'user.dart';

class AuthFacade {
  final authApi = AuthApi();

  Future<KinyokuUser> signIn() async {
    final authUser = await authApi.signInAnonimously();
    final user = KinyokuUser(id: authUser.uid);
    return user;
  }
}

final authFacadeProvider = Provider((ref) => AuthFacade());
