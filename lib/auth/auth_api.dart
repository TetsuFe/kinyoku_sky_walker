import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  Future<User> signInAnonimously() async {
    final userInfo = await FirebaseAuth.instance.signInAnonymously();
    print(userInfo);
    return userInfo.user;
  }
}
