import 'package:kinyoku_continue/supplemental_count/supplemental_label/models/goal.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

const supplementalLabelKey = 'supplementalLabelKey';

class SupplementalLabelRepository {
  void update(String supplementalLabelText) {
    sharedPreference.setString(supplementalLabelKey, supplementalLabelText);
  }

  SupplementalLabel read() {
    return SupplementalLabel(
        text: sharedPreference.getString(supplementalLabelKey) ?? '');
  }
}
