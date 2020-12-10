import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:kinyoku_continue/calendar/calendar_event_list_service.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';
import 'package:meta/meta.dart';

class CalenderUseCase {
  CalenderUseCase({@required this.repository});

  final ProhibitedMatterTimeRepository repository;

  Future<List<DateTime>> getAllProhibitedMatterDays() async {
    final allProhibitedMatterTimes = await repository.getAllWithoutFirst();
    final list = allProhibitedMatterTimes
        .map((e) => DateTime(e.date.year, e.date.month, e.date.day, 0, 0))
        .toSet()
        .toList()
          ..sort((a, b) => a.compareTo(b));
    return list;
  }

  final _calendarEventListService = CalendarEventListService();

  Future<EventList<Event>> getMarkedDateMap(
      List<DateTime> allProhibitedMatterDays) async {
    final firstResetData = await repository.getFirstResetData();
    if (firstResetData != null) {
      final firstResetDate = firstResetData.date;
      if (allProhibitedMatterDays.isEmpty) {
        return _calendarEventListService.makeKinyokuMarkEventList(
            firstResetDate: firstResetDate,
            markStartDate: DateTime.now(),
            allProhibitedMatterDays: allProhibitedMatterDays);
      } else {
        return _calendarEventListService.makeKinyokuMarkEventList(
            firstResetDate: firstResetDate,
            markStartDate: allProhibitedMatterDays[0],
            allProhibitedMatterDays: allProhibitedMatterDays);
      }
    } else {
      return EventList<Event>();
    }
  }
}
