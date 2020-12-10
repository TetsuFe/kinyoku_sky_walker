import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';

import 'month_week_calcurator.dart';

class MonthlyCarouselTimeService {
  List<List<List<ProhibitedMatterTime>>> getWeeklyDividedProhibitedMatterTimes(
      {DateTime now, List<ProhibitedMatterTime> prohibitedMatterTimes}) {
    if (prohibitedMatterTimes.isEmpty) {
      return [
        [[]]
      ];
    }

    var _now = now;
    _now ??= DateTime.now();
    // final days = [22, 15, 8, 1];
    // ignore: omit_local_variable_types
    List<List<List<ProhibitedMatterTime>>> prohibitedMatter3DMatrixForCarousel =
        [
      [[]]
    ];

    prohibitedMatterTimes.sort((a, b) => a.date.compareTo(b.date));
    final prohibitedMatterTimesSortedByDate = prohibitedMatterTimes;
    final reversedProhibitedMatterTimesSortedByDate =
        prohibitedMatterTimesSortedByDate.reversed.toList();
    print(reversedProhibitedMatterTimesSortedByDate[0].date);

    prohibitedMatter3DMatrixForCarousel = processlatestMonth(
        reversedProhibitedMatterTimesSortedByDate,
        _now,
        prohibitedMatter3DMatrixForCarousel);

    // _nowからでないと、差が切り捨てられてしまう可能性がある。これで時間を無駄にした
    // flutter: 2020-07-28 00:00:00.000
    // flutter: 0(日の差)
    // flutter: 1(日の差)
    // これで日のずれしか計算していないと、時間のずれの情報がなくなっていく！
    // 実際には、1日と19時間差があるが、19時間分が失われてずれていってしまう

    final monthWeekCalcurator = MonthWeekCalcurator();
    var prevDiffMonthFromNow = monthWeekCalcurator.culcurateDiffMonth(
        _now, reversedProhibitedMatterTimesSortedByDate[0]);
    var prevDiffWeekFromNow = monthWeekCalcurator.culcurateDiffWeek(
        _now, reversedProhibitedMatterTimesSortedByDate[0]);

    for (var prohibitedMatter in reversedProhibitedMatterTimesSortedByDate) {
      // 以下の関数群で同じ「現在時刻」を使う必要があるため使用

      final diffMonthFromNow =
          monthWeekCalcurator.culcurateDiffMonth(_now, prohibitedMatter);
      final diffWeekFromNow =
          monthWeekCalcurator.culcurateDiffWeek(_now, prohibitedMatter);

      final prohibitedMatterWeekNumber = calcurateWeekNumber(prohibitedMatter);

      print(diffMonthFromNow);
      print(prevDiffMonthFromNow);
      // 要素の追加
      print('adding month');
      if (diffMonthFromNow > prevDiffMonthFromNow) {
        for (var m = 0; m < diffMonthFromNow - prevDiffMonthFromNow; m++) {
          print('add month');
          prohibitedMatter3DMatrixForCarousel.add([[]]);
          print(
              prohibitedMatter3DMatrixForCarousel[diffMonthFromNow - 1].length);
          for (var n = 0; n < 4; n++) {
            if (prohibitedMatter3DMatrixForCarousel[diffMonthFromNow - 1]
                    .length <
                4) {
              print('add week');
              prohibitedMatter3DMatrixForCarousel[diffMonthFromNow - 1].add([]);
            }
          }
        }
      }
      print(prohibitedMatter.date);
      print(diffWeekFromNow);
      print(prevDiffWeekFromNow);
      print('adding week');
      if (diffWeekFromNow > prevDiffWeekFromNow) {
        print('diffWeekFromNow > prevDiffWeekFromNow');
        for (var n = 0; n < diffWeekFromNow - prevDiffWeekFromNow; n++) {
          if (prohibitedMatter3DMatrixForCarousel[diffMonthFromNow].length <
              4) {
            print('add week');
            prohibitedMatter3DMatrixForCarousel[diffMonthFromNow].add([]);
          }
        }
      }

      print(diffMonthFromNow);
      print(prohibitedMatter.date);
      print(prohibitedMatterWeekNumber);
      prohibitedMatter3DMatrixForCarousel[diffMonthFromNow]
              [prohibitedMatterWeekNumber]
          .add(prohibitedMatter);
      print(prohibitedMatter.date);
      prevDiffMonthFromNow = diffMonthFromNow;
      prevDiffWeekFromNow = diffWeekFromNow;
    }
    // 最後の月(実際にはこの後で逆転させるので、最初の月となる)のあまりの週(4-n)を埋める
    // これを行わないと、1週分しか埋められず、
    // 実際にはindexで 4 - 1 = 3 -> 週換算で 3 + 1 = 4番目の週のみとなってしまうのだが
    // 配列の要素が1個しかないので、この後の逆転でも1を逆転させて1となり、1週目になってしまう。
    // 最初の月＝最後の月の時、処理が２重に走ると４週より多い数になってしまうので、
    // それを条件分岐で防ぐ
    if (_now.month !=
        reversedProhibitedMatterTimesSortedByDate.last.date.month) {
      final carouselLastMonthWeekLength =
          prohibitedMatter3DMatrixForCarousel[prevDiffMonthFromNow].length;
      if (prohibitedMatter3DMatrixForCarousel[prevDiffMonthFromNow].length !=
          4) {
        for (var _ = carouselLastMonthWeekLength; _ < 4; _++) {
          print('add empty week');
          prohibitedMatter3DMatrixForCarousel[prevDiffMonthFromNow].add([]);
        }
      }
    }

    _printAllWeeklyProhibitedMatterLength(prohibitedMatter3DMatrixForCarousel);

    return _reverseAllAxis(prohibitedMatter3DMatrixForCarousel);
  }

  void _printAllWeeklyProhibitedMatterLength(
      List<List<List<ProhibitedMatterTime>>>
          prohibitedMatter3DMatrixForCarousel) {
    print('last');
    for (var z in prohibitedMatter3DMatrixForCarousel) {
      for (var y in z) {
        print(y.length);
      }
    }
  }

  List<List<List<ProhibitedMatterTime>>> processlatestMonth(
      List<ProhibitedMatterTime> reversedProhibitedMatterTimesSortedByDate,
      DateTime now,
      List<List<List<ProhibitedMatterTime>>>
          prohibitedMatter3DMatrixForCarousel) {
    // 最初の月だけ特例計算。
    // 例: 8/1の場合、8/22, 8/15, 8/8 週分の空配列を追加する
    final latest = reversedProhibitedMatterTimesSortedByDate[0];
    print(latest.date.day);
    final latestWeekNumber =
        3 - ((latest.date.day - 1 < 0 ? 0 : latest.date.day - 1) / 7).floor();
    print(latestWeekNumber);
    final diffLatestMonthFromNow = now.month - latest.date.month;
    if (diffLatestMonthFromNow != 0) {
      for (var i = 0; i < diffLatestMonthFromNow; i++) {
        prohibitedMatter3DMatrixForCarousel.add([[]]);
      }
    }

    // 最初（日付的に最新）の要素が最初の月の場合だけ、
    // 先に空配列で埋めた週の分先に要素を追加する
    if (reversedProhibitedMatterTimesSortedByDate.isNotEmpty) {
      if (now.month == latest.date.month || diffLatestMonthFromNow != 0) {
        for (var _ = 0; _ < latestWeekNumber; _++) {
          print('add week');
          prohibitedMatter3DMatrixForCarousel[diffLatestMonthFromNow].add([]);
        }
      }
    }
    return prohibitedMatter3DMatrixForCarousel;
  }

  int calcurateWeekNumber(ProhibitedMatterTime prohibitedMatter) {
    int prohibitedMatterWeekNumber;
    if (((prohibitedMatter.date.day - 1 < 0
                    ? 0
                    : prohibitedMatter.date.day - 1) /
                7)
            .floor() <
        4) {
      prohibitedMatterWeekNumber = 3 -
          ((prohibitedMatter.date.day - 1 < 0
                      ? 0
                      : prohibitedMatter.date.day - 1) /
                  7)
              .floor();
    } else {
      prohibitedMatterWeekNumber = 0;
    }
    return prohibitedMatterWeekNumber;
  }

  List<List<List<ProhibitedMatterTime>>> _reverseAllAxis(
      List<List<List<ProhibitedMatterTime>>>
          prohibitedMatter3DMatrixForCarousel) {
    // 月の逆転
    final monthlyReversedProhibitedMatter3DMatrixForCarousel =
        prohibitedMatter3DMatrixForCarousel.reversed.toList();
    // 週の逆転
    for (var z = 0;
        z < monthlyReversedProhibitedMatter3DMatrixForCarousel.length;
        z++) {
      monthlyReversedProhibitedMatter3DMatrixForCarousel[z] =
          monthlyReversedProhibitedMatter3DMatrixForCarousel[z]
              .reversed
              .toList();
    }
    // 日の逆転
    for (var z = 0;
        z < monthlyReversedProhibitedMatter3DMatrixForCarousel.length;
        z++) {
      for (var y = 0;
          y < monthlyReversedProhibitedMatter3DMatrixForCarousel[z].length;
          y++) {
        monthlyReversedProhibitedMatter3DMatrixForCarousel[z][y] =
            monthlyReversedProhibitedMatter3DMatrixForCarousel[z][y]
                .reversed
                .toList();
      }
    }
    return monthlyReversedProhibitedMatter3DMatrixForCarousel;
  }
}
