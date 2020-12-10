import 'models/prohibited_matter_time.dart';

class MonthlyCarouselDiffService {
  List<List<int>> makeWeeklyPercentDiffMatrix(
      List<List<List<ProhibitedMatterTime>>>
          monthlyReversedProhibitedMatter3DMatrixForCarousel) {
    print('monthlyReversedProhibitedMatter3DMatrixForCarousel.length');
    print(monthlyReversedProhibitedMatter3DMatrixForCarousel.length);
    for (var m in monthlyReversedProhibitedMatter3DMatrixForCarousel) {
      for (var w in m) {
        for (var e in w) {
          print(e.date);
        }
      }
    }
    // ignore: omit_local_variable_types
    final List<List<int>> weeklyPercentDiffSumList = [[]];
    var prevWeeklySum = 1;
    for (var i = 0;
        i < monthlyReversedProhibitedMatter3DMatrixForCarousel.length;
        i++) {
      for (var j = 0;
          j < monthlyReversedProhibitedMatter3DMatrixForCarousel[i].length;
          j++) {
        if (monthlyReversedProhibitedMatter3DMatrixForCarousel[i][j]
            .isNotEmpty) {
          final sum = monthlyReversedProhibitedMatter3DMatrixForCarousel[i][j]
              .map((a) => a.hours * 60 + a.minutes)
              .reduce((a, b) => a + b);
          if (i == 0 && j == 0) {
            weeklyPercentDiffSumList[i].add(0);
          } else {
            if (prevWeeklySum != 0) {
              weeklyPercentDiffSumList[i]
                  .add((100 * (sum - prevWeeklySum) / prevWeeklySum).floor());
            } else {
              weeklyPercentDiffSumList[i].add(0);
            }
          }
          prevWeeklySum = sum;
        } else {
          weeklyPercentDiffSumList[i].add(0);
          prevWeeklySum = 0;
        }
      }
      if (i != monthlyReversedProhibitedMatter3DMatrixForCarousel.length - 1) {
        weeklyPercentDiffSumList.add([]);
      }
    }
    print(weeklyPercentDiffSumList.length);
    for (var w in weeklyPercentDiffSumList) {
      print(w.length);
    }
    print(monthlyReversedProhibitedMatter3DMatrixForCarousel.length);
    for (var m in monthlyReversedProhibitedMatter3DMatrixForCarousel) {
      print(m.length);
    }
    return weeklyPercentDiffSumList;
  }
}
