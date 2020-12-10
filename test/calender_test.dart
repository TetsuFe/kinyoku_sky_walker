import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kinyoku_continue/calendar/calendar_event_list_service.dart';
import 'package:kinyoku_continue/calendar/calendar_usecase.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';
import 'package:mockito/mockito.dart';

class MockProhibitedMatterTimeRepository extends Mock
    implements ProhibitedMatterTimeRepository {}

void main() {
  test('get empty datetimes for calender', () async {
    final ProhibitedMatterTimeRepository repository =
        MockProhibitedMatterTimeRepository();
    when(repository.getAllWithoutFirst()).thenAnswer((_) => Future.value([]));
    final useCase = CalenderUseCase(repository: repository);
    final days = await useCase.getAllProhibitedMatterDays();
    expect(days, []);
  });

  test(
      'get datetimes for calender'
      'let user did prohibited matter twice but at same day', () async {
    final ProhibitedMatterTimeRepository repository =
        MockProhibitedMatterTimeRepository();
    when(repository.getAllWithoutFirst()).thenAnswer((_) => Future.value([
          ProhibitedMatterTime(
              hours: 0, minutes: 0, date: DateTime(2020, 1, 1, 1, 1)),
          ProhibitedMatterTime(
              hours: 0, minutes: 0, date: DateTime(2020, 1, 1, 2, 0))
        ]));
    final useCase = CalenderUseCase(repository: repository);
    final days = await useCase.getAllProhibitedMatterDays();
    expect(days, {DateTime(2020, 1, 1, 0, 0)});
  });

  test(
      'get datetimes for calender'
      'let user did prohibited matter twice and at different days', () async {
    final ProhibitedMatterTimeRepository repository =
        MockProhibitedMatterTimeRepository();
    when(repository.getAllWithoutFirst()).thenAnswer((_) => Future.value([
          ProhibitedMatterTime(
              hours: 0, minutes: 0, date: DateTime(2020, 1, 1, 1, 1)),
          ProhibitedMatterTime(
              hours: 0, minutes: 0, date: DateTime(2020, 1, 2, 2, 0))
        ]));
    final useCase = CalenderUseCase(repository: repository);
    final days = await useCase.getAllProhibitedMatterDays();
    expect(days, {DateTime(2020, 1, 1, 0, 0), DateTime(2020, 1, 2, 0, 0)});
  });

  test('service get empty datetime list', () {
    final service = CalendarEventListService();
    final markedDateMap = service.makeKinyokuMarkEventList(
        firstResetDate: DateTime(2020, 9, 1),
        now: DateTime(2020, 9, 2),
        markStartDate: DateTime(2020, 9, 2),
        allProhibitedMatterDays: []);
    expect(markedDateMap.events.values.toList(), [
      [Event(date: DateTime(2020, 9, 2, 0, 0), icon: service.eventIcon)]
    ]);
  });

  test('same day between first reset and now with no second reset ', () {
    final service = CalendarEventListService();
    final markedDateMap = service.makeKinyokuMarkEventList(
        firstResetDate: DateTime(2020, 9, 1),
        now: DateTime(2020, 9, 1, 1, 1),
        markStartDate: DateTime(2020, 9, 1),
        allProhibitedMatterDays: [DateTime(2020, 9, 1)]);
    expect(markedDateMap.events.values.toList(), [
      [Event(date: DateTime(2020, 9, 1), icon: service.prohibitedEventIcon)]
    ]);
  });

  test('same day between first reset and second reset and now', () {
    final service = CalendarEventListService();
    final markedDateMap = service.makeKinyokuMarkEventList(
        firstResetDate: DateTime(2020, 9, 1),
        now: DateTime(2020, 9, 1, 1, 1),
        markStartDate: DateTime(2020, 9, 1),
        allProhibitedMatterDays: [DateTime(2020, 9, 1, 0, 0)]);
    expect(markedDateMap.events.values.toList(), [
      [
        Event(
            date: DateTime(2020, 9, 1, 0, 0), icon: service.prohibitedEventIcon)
      ]
    ]);
  });

  test('same day between first reset and second reset', () {
    final service = CalendarEventListService();
    final markedDateMap = service.makeKinyokuMarkEventList(
        firstResetDate: DateTime(2020, 9, 1),
        now: DateTime(2020, 9, 2, 1, 1),
        markStartDate: DateTime(2020, 9, 1),
        allProhibitedMatterDays: [DateTime(2020, 9, 1)]);
    expect(markedDateMap.events.values.toList(), [
      [
        Event(date: DateTime(2020, 9, 1), icon: service.prohibitedEventIcon),
      ],
      [
        Event(date: DateTime(2020, 9, 2), icon: service.eventIcon),
      ],
    ]);
  });

  test('which prohibited matter db has datas for two months', () {
    final service = CalendarEventListService();
    final markedDateMap = service.makeKinyokuMarkEventList(
        firstResetDate: DateTime(2020, 8, 28),
        now: DateTime(2020, 9, 2, 1, 1),
        markStartDate: DateTime(2020, 8, 28),
        allProhibitedMatterDays: [DateTime(2020, 8, 30), DateTime(2020, 9, 1)]);
    expect(markedDateMap.events.values.toList(), [
      [
        Event(date: DateTime(2020, 8, 29, 0, 0), icon: service.eventIcon),
      ],
      [
        Event(
            date: DateTime(2020, 8, 30, 0, 0),
            icon: service.prohibitedEventIcon),
      ],
      [
        Event(date: DateTime(2020, 8, 31, 0, 0), icon: service.eventIcon),
      ],
      [
        Event(
            date: DateTime(2020, 9, 1, 0, 0),
            icon: service.prohibitedEventIcon),
      ],
      [
        Event(date: DateTime(2020, 9, 2, 0, 0), icon: service.eventIcon),
      ],
    ]);
  });

  test('second day is same day with now', () {
    final service = CalendarEventListService();
    final markedDateMap = service.makeKinyokuMarkEventList(
        firstResetDate: DateTime(2020, 8, 28),
        now: DateTime(2020, 8, 30, 1, 1),
        markStartDate: DateTime(2020, 8, 28),
        allProhibitedMatterDays: [DateTime(2020, 8, 30, 0, 0)]);
    expect(markedDateMap.events.values.toList(), [
      [
        Event(date: DateTime(2020, 8, 29, 0, 0), icon: service.eventIcon),
      ],
      [
        Event(
            date: DateTime(2020, 8, 30, 0, 0),
            icon: service.prohibitedEventIcon),
      ],
    ]);
  });
  test('first reset only , which is not same day with now', () {
    final service = CalendarEventListService();
    final markedDateMap = service.makeKinyokuMarkEventList(
        firstResetDate: DateTime(2020, 8, 28),
        now: DateTime(2020, 9, 2, 0, 0),
        markStartDate: DateTime(2020, 8, 28),
        allProhibitedMatterDays: []);
    expect(markedDateMap.events.values.toList(), [
      [
        Event(date: DateTime(2020, 8, 29, 0, 0), icon: service.eventIcon),
      ],
      [
        Event(date: DateTime(2020, 8, 30, 0, 0), icon: service.eventIcon),
      ],
      [
        Event(date: DateTime(2020, 8, 31, 0, 0), icon: service.eventIcon),
      ],
      [
        Event(date: DateTime(2020, 9, 1, 0, 0), icon: service.eventIcon),
      ],
    ]);
  });
}
