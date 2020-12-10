import 'package:kinyoku_continue/goal/models/goal.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

const String goalKey = 'goalKey';

class GoalRepository {
  void update(int goalDays) {
    assert(int != null);
    sharedPreference.setInt(goalKey, goalDays);
  }

  Goal read() {
    return Goal(sharedPreference.getInt(goalKey) ?? 5);
  }
}
