import 'package:kinyoku_continue/this_app_shared_preference.dart';

const titleKey = 'titleKey';
const currentTitleKey = 'currentTitleKey';

abstract class TitleRepository {
  String read();

  void save(String title);
}

class AccumulatedCountTitleRepository implements TitleRepository {
  @override
  String read() {
    return sharedPreference.getString(titleKey);
  }

  @override
  void save(String title) {
    sharedPreference.setString(titleKey, title);
  }
}

class CurrentCountTitleRepository implements TitleRepository {
  @override
  String read() {
    return sharedPreference.getString(currentTitleKey);
  }

  @override
  void save(String title) {
    sharedPreference.setString(currentTitleKey, title);
  }
}
