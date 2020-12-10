import 'package:kinyoku_continue/counter/count_state_date_key.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

class TutorialRepository {
  bool isNotReset() {
    return sharedPreference.getString(countKey) == null;
  }
}
