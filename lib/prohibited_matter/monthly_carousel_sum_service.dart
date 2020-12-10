import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';

class MonthlyCarouselSumService {
  /// 新しい順に月間発散時間を返す
  /// 新しい順の配列を受け取る
  List<int> makeMonthlyTimesList(
      List<List<List<ProhibitedMatterTime>>>
          monthlyReversedProhibitedMatter3DMatrixForCarousel) {
    // ignore: omit_local_variable_types
    final monthlySum = monthlyReversedProhibitedMatter3DMatrixForCarousel
        .map((m) => m.map((w) {
              if (w.isNotEmpty) {
                return w
                    .map<int>((a) => a.hours * 60 + a.minutes)
                    .reduce((value, b) => value + b);
              } else {
                return 0;
              }
            }).reduce((value, b) => value + b))
        .toList();
    return monthlySum;
  }
}
