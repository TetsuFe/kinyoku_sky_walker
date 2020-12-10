import 'package:kinyoku_continue/title/stoic_days_count_rule.dart';

class GetStoicDaysCountRuleUseCase {
  final stoicDaysCountRule = StoicDaysCountRule();

  StoicDaysCountRuleType getCurrentRule() {
    return stoicDaysCountRule.getCurrentRule();
  }
}
