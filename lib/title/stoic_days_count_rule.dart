import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

enum StoicDaysCountRuleType {
  accumulated,
  current,
}

const stoicDaysCountRuleTypeKey = 'stoicDaysCountRuleType';

class StoicDaysCountRule {
  void switchCountRule(StoicDaysCountRuleType ruleType) {
    if (ruleType == StoicDaysCountRuleType.accumulated) {
      sharedPreference.setString(stoicDaysCountRuleTypeKey,
          StoicDaysCountRuleType.accumulated.toString());
    } else {
      sharedPreference.setString(
          stoicDaysCountRuleTypeKey, StoicDaysCountRuleType.current.toString());
    }
  }

  StoicDaysCountRuleType getCurrentRule() {
    final ruleTypeString =
        sharedPreference.getString(stoicDaysCountRuleTypeKey);
    if (ruleTypeString == StoicDaysCountRuleType.accumulated.toString()) {
      return StoicDaysCountRuleType.accumulated;
    } else {
      return StoicDaysCountRuleType.current;
    }
  }

  /// 禁欲成功日数 = 初回リセット（利用開始時）から現在時刻までの日数 - リセットした日数
  /// を計算し、称号titleを更新する
  int culcurateStoicDays(List<ProhibitedMatterTime> allProhibitedMatters,
      ProhibitedMatterTime firstResetData) {
    final stoicDaysCountRuleTypeString =
        sharedPreference.getString(stoicDaysCountRuleTypeKey);
    if (stoicDaysCountRuleTypeString == null) {
      sharedPreference.setString(
          stoicDaysCountRuleTypeKey, StoicDaysCountRuleType.current.toString());
    }
    if (stoicDaysCountRuleTypeString ==
        StoicDaysCountRuleType.accumulated.toString()) {
      final allProhibitedMatterDates =
          allProhibitedMatters.map((prohibitedMatter) => prohibitedMatter.date);
      int currentYear;
      int currentMonth;
      int currentDay;
      var resetDaysLength = 0;
      for (var date in allProhibitedMatterDates) {
        print(date);
        if (currentYear != date.year ||
            currentMonth != date.month ||
            currentDay != date.day) {
          currentYear = date.year;
          currentMonth = date.month;
          currentDay = date.day;
          resetDaysLength++;
        }
      }
      final stoicDays = DateTime.now().difference(firstResetData.date).inDays -
          resetDaysLength;
      return stoicDays;
    } else {
      final stoicDays = DateTime.now()
          .difference(
              allProhibitedMatters[allProhibitedMatters.length - 1].date)
          .inDays;
      return stoicDays;
    }
  }
}
