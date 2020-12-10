import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';

class MonthWeekCalcurator {
  int culcurateDiffMonth(DateTime _now, ProhibitedMatterTime prohibitedMatter) {
    final diffMonth = -(prohibitedMatter.date.month -
        _now.month); // ex: 7 - 8 = -1, 1 - 12 = -11
    print('monthDiff');
    print(diffMonth);
    return diffMonth;
  }

  int culcurateDiffWeek(DateTime _now, ProhibitedMatterTime prohibitedMatter) {
    final diffMonth = culcurateDiffMonth(_now, prohibitedMatter);
    if (diffMonth == 0) {
      print(prohibitedMatter.date);
      print(_now);
      print('weekDiffFromDay');
      print(((_now.day - 1 < 0 ? 0 : _now.day - 1) / 7).floor() -
          ((prohibitedMatter.date.day - 1 < 0
                      ? 0
                      : prohibitedMatter.date.day - 1) /
                  7)
              .floor());
      return ((_now.day - 1 < 0 ? 0 : _now.day - 1) / 7).floor() -
          ((prohibitedMatter.date.day - 1 < 0
                      ? 0
                      : prohibitedMatter.date.day - 1) /
                  7)
              .floor();
    } else {
      final weekDiffFromDay =
          ((_now.day - 1 < 0 ? 0 : _now.day - 1) / 7).floor() -
              ((prohibitedMatter.date.day - 1 < 0
                          ? 0
                          : prohibitedMatter.date.day - 1) /
                      7)
                  .floor();
      print('weekDiffFromDay');
      print(weekDiffFromDay + diffMonth * 4);
      if (weekDiffFromDay < 0) {
        print('plusplus');
        print(weekDiffFromDay + diffMonth * 4 > 1);
        print('ああああああああ');
        return weekDiffFromDay + diffMonth * 4;
      } else {
        if (weekDiffFromDay > 0) {
          print('ああああああああ');
          print(weekDiffFromDay);
          print('ああああああああ');
        }
        return weekDiffFromDay + diffMonth * 4;
      }
    }
  }
}
