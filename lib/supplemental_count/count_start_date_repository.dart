import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/counter/models/count_start_date.dart';
import 'package:kinyoku_continue/supplemental_count/models/count_start_date.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

const supplementalCountKey = 'supplementalCountKey';

class SupplementalCountStateDateRepository {
  void reset(DateTime dateTime) async {
    assert(dateTime != null);
    sharedPreference.setString(supplementalCountKey, dateTime.toString());
  }

  CountStartDate read() {
    final countStartDate = sharedPreference.getString(supplementalCountKey);
    if (countStartDate != null) {
      return SupplementalCountStartDate(value: DateTime.parse(countStartDate));
    } else {
      return null;
    }
  }
}

final supplementalCountStateDateRepository =
    Provider((ref) => SupplementalCountStateDateRepository());
