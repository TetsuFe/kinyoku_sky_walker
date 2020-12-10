import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:kinyoku_continue/calendar/month_day_length.dart';
import 'package:meta/meta.dart';

class CalendarEventListService {
  final Widget eventIcon = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Colors.green,
    ),
  );
  final Widget prohibitedEventIcon = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Colors.red,
    ),
  );

  EventList<Event> makeKinyokuMarkEventList(
      {@required DateTime firstResetDate,
      //ignore: always_require_non_null_named_parameters
      DateTime now,
      @required DateTime markStartDate,
      @required List<DateTime> allProhibitedMatterDays}) {
    assert(firstResetDate != null);
    assert(markStartDate != null);
    assert(allProhibitedMatterDays != null);
    var _now = now;
    _now ??= DateTime.now();
    assert(allProhibitedMatterDays != null);
    var date = firstResetDate;
    print(markStartDate);
    print(date);
    final endDate = _now;
    final markedDateMap = EventList<Event>();

    final calenderCurrentYear = date.year;
    final calenderCurrentMonth = date.month;
    // 発散回数が０のとき
    if (allProhibitedMatterDays.isEmpty) {
      if (date.day == endDate.day) {
        markedDateMap.add(
            date,
            Event(
              date: date,
              icon: eventIcon,
            ));
        return markedDateMap;
      }
      if (endDate.year == firstResetDate.year &&
          endDate.month == firstResetDate.month) {
        for (var i = date.day; i < endDate.day; i++) {
          final day =
              DateTime(calenderCurrentYear, calenderCurrentMonth, 1 + i);
          markedDateMap.add(
              day,
              Event(
                date: day,
                icon: eventIcon,
              ));
        }
        return markedDateMap;
      } else {
        final endDay = MonthDayLength
            .monthDayLength['$calenderCurrentYear$calenderCurrentMonth'];
        for (var i = date.day; i < endDay; i++) {
          final day =
              DateTime(calenderCurrentYear, calenderCurrentMonth, 1 + i);
          markedDateMap.add(
              day,
              Event(
                date: day,
                icon: eventIcon,
              ));
        }
        if (date.month == 12) {
          date = DateTime(date.year + 1, 1);
        } else {
          date = DateTime(date.year, date.month + 1, 1);
        }
        // 現在月の最初の日から現在時刻まで禁欲成功日としてマーカーリストをつくる
        for (var i = date.day; i < endDate.day; i++) {
          final calenderCurrentYear = date.year;
          final calenderCurrentMonth = date.month;
          final day = DateTime(calenderCurrentYear, calenderCurrentMonth, i);
          markedDateMap.add(
              day,
              Event(
                date: day,
                icon: eventIcon,
              ));
        }
        return markedDateMap;
      }
    }

    while (date.isBefore(endDate)) {
      final calenderCurrentYear = date.year;
      final calenderCurrentMonth = date.month;
      final endDay = MonthDayLength
          .monthDayLength['$calenderCurrentYear$calenderCurrentMonth'];
      if (calenderCurrentYear == firstResetDate.year &&
          calenderCurrentMonth == firstResetDate.month) {
        // 下のfor文でfirstResetDate.day - 1となっている分をここで調整
        if (firstResetDate.day == allProhibitedMatterDays[0].day &&
            firstResetDate.month == allProhibitedMatterDays[0].month &&
            firstResetDate.year == allProhibitedMatterDays[0].year) {
          markedDateMap.add(
              allProhibitedMatterDays[0],
              Event(
                date: allProhibitedMatterDays[0],
                icon: prohibitedEventIcon,
              ));
        }
        for (var i = firstResetDate.day - 1; i < endDay; i++) {
          final day =
              DateTime(calenderCurrentYear, calenderCurrentMonth, 1 + i);
          print(day.day);
          if (day.day == firstResetDate.day) {
            continue;
          }
          if (day.isAfter(endDate) && day.isAfter(_now)) {
            if (date.month == 12) {
              date = DateTime(date.year + 1, 1);
            } else {
              date = DateTime(date.year, date.month + 1);
            }
            break;
          }
          if (allProhibitedMatterDays.contains(day)) {
            markedDateMap.add(
                day,
                Event(
                  date: day,
                  icon: prohibitedEventIcon,
                ));
          } else {
            markedDateMap.add(
                day,
                Event(
                  date: day,
                  icon: eventIcon,
                ));
          }
        }
      } else {
        addMonthMark(
            endDay: endDay,
            endDate: endDate,
            now: _now,
            markedDateMap: markedDateMap,
            allProhibitedMatterDays: allProhibitedMatterDays,
            calenderCurrentYear: calenderCurrentYear,
            calenderCurrentMonth: calenderCurrentMonth);
      }
      if (date.month == 12) {
        date = DateTime(date.year + 1, 1);
      } else {
        date = DateTime(date.year, date.month + 1);
      }
    }
    return markedDateMap;
  }

  void addMonthMark(
      {@required int endDay,
      @required DateTime endDate,
      @required DateTime now,
      @required EventList<Event> markedDateMap,
      @required List<DateTime> allProhibitedMatterDays,
      @required int calenderCurrentYear,
      @required int calenderCurrentMonth}) {
    for (var i = 0; i < endDay; i++) {
      final day = DateTime(calenderCurrentYear, calenderCurrentMonth, 1 + i);
      if (day.isAfter(endDate) && day.isAfter(now)) {
        break;
      }
      if (allProhibitedMatterDays.contains(day)) {
        markedDateMap.add(
            day,
            Event(
              date: day,
              icon: prohibitedEventIcon,
            ));
      } else {
        markedDateMap.add(
            day,
            Event(
              date: day,
              icon: eventIcon,
            ));
      }
    }
  }
}
