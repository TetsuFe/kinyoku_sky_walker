import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time_monthly_carousel_notifier.dart';
import 'package:meta/meta.dart';

class ProhibitedMatterTimeMonthlyCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer((context, read) {
      final prohibitedMatterTimeMonthlyCarouselNotifier =
          read(prohibitedMatterTimeMonthlyCarouselNotifierProvider);
      final prohibitedMatterTimeMatrixForCarousel =
          prohibitedMatterTimeMonthlyCarouselNotifier
              .prohibitedMatterTimeMatrixForCarousel;
      final weeklyPercentDiffMonthlyParcial =
          prohibitedMatterTimeMonthlyCarouselNotifier
              .weeklyPercentDiffMonthlyParcial;
      if (weeklyPercentDiffMonthlyParcial.isEmpty) {
        return const Text('すみません、エラーです。おそらく近日中に対応されます。'
            'Twitter(@kinyoku_support)にバグ報告をしていただけると嬉しいです。');
      }
      if (prohibitedMatterTimeMatrixForCarousel.isEmpty) {
        return const Text('すみません、エラーです。おそらく近日中に対応されます。'
            'Twitter(@kinyoku_support)にバグ報告をしていただけると嬉しいです。');
      } else {
        return Column(children: <Widget>[
          CarouselHeader(),
          ListView(
            primary: false,
            shrinkWrap: true,
            children: prohibitedMatterTimeMatrixForCarousel
                .indexedMap((weekIndex, array) {
              if (array.isEmpty) {
                return const ListTile(title: Text('この期間のデータはありません'));
              } else {
                final weeklyProhibitedMatterTimeSum =
                    getWeeklyProhibitedMatterTimeSum(array);
                return WeeklyProhibitedMatterTimeSumListTile(
                  weekRange: getWeekRange(weekIndex),
                  hours: weeklyProhibitedMatterTimeSum.hours,
                  minutes: weeklyProhibitedMatterTimeSum.minutes,
                  weeklyPercentDiff: weeklyPercentDiffMonthlyParcial[weekIndex],
                );
              }
            }).toList(),
          ),
        ]);
      }
    });
  }

  /// weekIndexは0から3の4週間分のindex。簡単のため、4週目は22日以降とする
  String getWeekRange(int weekIndex) {
    if (weekIndex < 3) {
      return '${1 + 7 * weekIndex}-${7 + 7 * weekIndex}日';
    } else if (weekIndex == 3) {
      return '22日-';
    } else {
      return 'エラー';
    }
  }

  MinutesHours getWeeklyProhibitedMatterTimeSum(
      List<ProhibitedMatterTime> weeklyProhibitedMatterTimes) {
    if (weeklyProhibitedMatterTimes.isEmpty) {
      return null;
    }
    final minutesSum = weeklyProhibitedMatterTimes
        .map((ProhibitedMatterTime e) => e.minutes)
        .reduce((value, element) => value + element);
    final hoursSum = weeklyProhibitedMatterTimes
        .map((ProhibitedMatterTime e) => e.hours)
        .reduce((value, element) => value + element);
    return MinutesHours(
        hours: hoursSum + (minutesSum / 60).floor(), minutes: minutesSum % 60);
  }
}

class WeeklyProhibitedMatterTimeSumListTile extends StatelessWidget {
  const WeeklyProhibitedMatterTimeSumListTile(
      {@required this.weekRange,
      @required this.hours,
      @required this.minutes,
      @required this.weeklyPercentDiff});
  final String weekRange;
  final int hours;
  final int minutes;
  final int weeklyPercentDiff;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: ListTile(
          title: Text('$weekRange $hours時間'
              ' $minutes分'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '先週比 '
                // ignore: lines_longer_than_80_chars
                '${weeklyPercentDiff > 0 ? '＋$weeklyPercentDiff' : '−${-weeklyPercentDiff}'}%',
                style: TextStyle(
                    color: weeklyPercentDiff > 0 ? Colors.red : Colors.green),
              ),
            ],
          )),
    );
  }
}

class MinutesHours {
  MinutesHours({@required this.hours, @required this.minutes});
  final int hours;
  final int minutes;
}

class CarouselHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      (context, read) {
        final prohibitedMatterTimeMonthlyCarouselNotifier =
            read(prohibitedMatterTimeMonthlyCarouselNotifierProvider);
        final monthIndex =
            read(prohibitedMatterTimeMonthlyCarouselNotifierProvider)
                .monthIndex;
        final monthLength =
            prohibitedMatterTimeMonthlyCarouselNotifier.monthLength;
        final monthlyTimes =
            prohibitedMatterTimeMonthlyCarouselNotifier.monthlyTimes;
        // print(monthLength);
        // print('index: $monthIndex');
        final currentYearAndMonth = DateFormat('yyyy年 MM月', 'ja_JP').format(
            DateTime.now().subtract(
                Duration(days: 30 * ((monthLength - 1) - monthIndex))));
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton.icon(
                onPressed:
                    prohibitedMatterTimeMonthlyCarouselNotifier.goPreviousMonth,
                icon: Icon(
                  Icons.arrow_left,
                  color: Theme.of(context).primaryColor,
                ),
                label: const Text('')),
            Text(
              '$currentYearAndMonth\n'
              '${monthlyTimes ~/ 60}時間 ${monthlyTimes % 60}分',
              textAlign: TextAlign.center,
            ),
            FlatButton.icon(
                onPressed:
                    prohibitedMatterTimeMonthlyCarouselNotifier.goNextMonth,
                icon: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
                label: const Text('')),
          ],
        );
      },
    );
  }
}

extension IndexedMap<T> on List<T> {
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(index, element));
    });
    return list;
  }
}
