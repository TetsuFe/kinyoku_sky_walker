import 'package:kinyoku_continue/share/share.dart';
import 'package:kinyoku_continue/title/stoic_days_count_rule.dart';

class GetTitleShareProvider extends ShareProvider {
  Future<void> openPlatformShareDialogForGetTitle(
      int stoicDays, String titleName) async {
    final countRule = StoicDaysCountRule().getCurrentRule();
    await openPlatformShareTextDialog(
        // ignore: lines_longer_than_80_chars
        '${countRule == StoicDaysCountRuleType.accumulated ? '累計' : '連続'}で禁欲$stoicDays日を達成したので、称号「$titleName」を獲得しました。\n'
        '$twitterAccountIdWithAtmark\n'
        '${appUrl()}');
    return;
  }
}
