import '../stoic_days_count_rule.dart';

class SwitchTitleUseCase {
  final stoicDaysCountRule = StoicDaysCountRule();

  void switchStoicDaysCountRule(StoicDaysCountRuleType ruleType) {
    stoicDaysCountRule.switchCountRule(ruleType);
  }
}
