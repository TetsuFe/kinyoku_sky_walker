import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

class MemoRepository {
  void add(DateTime datetime, String memoBody) {
    sharedPreference.setString('calendar_memo_$datetime', memoBody);
  }

  String read(DateTime datetime) {
    return sharedPreference.getString('calendar_memo_$datetime');
  }
}

final memoRepositoryProvider = Provider((_) => MemoRepository());
