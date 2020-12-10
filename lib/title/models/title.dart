import 'package:kinyoku_continue/title/models/current_title_names.dart';
import 'package:kinyoku_continue/title/models/title_names.dart';
import 'package:kinyoku_continue/title/models/title_service.dart';
import 'package:kinyoku_continue/title/stoic_days_count_rule.dart';
import 'package:meta/meta.dart';

class KinyokuTitle {
  KinyokuTitle({@required this.name, @required this.stoicDays});

  final String name;
  final int stoicDays;

  String nextTitleName() {
    final rule = StoicDaysCountRule().getCurrentRule();
    if (rule == StoicDaysCountRuleType.accumulated) {
      final index = TitleService.getTitleIndex(stoicDays);
      if (name == null) {
        return titleNames[0];
      } else if (index == titleNames.length - 1) {
        return null;
      } else {
        return titleNames[index + 1];
      }
    } else {
      final index = TitleService.getCurrentTitleIndex(stoicDays);
      if (name == null) {
        return currentTitleNames[0];
      } else if (index == currentTitleNames.length - 1) {
        return null;
      } else {
        return currentTitleNames[index + 1];
      }
    }
  }

  int getNextDaysForNextTitle() {
    final rule = StoicDaysCountRule().getCurrentRule();
    if (rule == StoicDaysCountRuleType.accumulated) {
      return TitleService.getDaysForNextTitle(stoicDays);
    } else {
      return TitleService.getDaysForNextCurrentTitle(stoicDays);
    }
  }
}
