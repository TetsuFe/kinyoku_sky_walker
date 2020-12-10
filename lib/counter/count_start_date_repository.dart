import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/counter/models/count_start_date.dart';
import 'package:kinyoku_continue/reset/reset_api.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'count_state_date_key.dart';

class CountStateDateRepository {
  CountStateDateRepository(
      {@required this.resetApi, @required this.sharedPreferences});

  final ResetApi resetApi;
  final SharedPreferences sharedPreferences;

  void reset(DateTime dateTime) async {
    assert(dateTime != null);
    sharedPreferences.setString(countKey, dateTime.toString());
    resetApi.saveResetDate(dateTime);
  }

  CountStartDate read() {
    final countStartDate = sharedPreferences.getString(countKey);
    if (countStartDate != null) {
      return CountStartDate(value: DateTime.parse(countStartDate));
    } else {
      return null;
    }
  }
}

final countStateDateRepositoryProvider = Provider((ref) =>
    CountStateDateRepository(
        resetApi: ref.read(resetApiProvider),
        sharedPreferences: sharedPreference));
