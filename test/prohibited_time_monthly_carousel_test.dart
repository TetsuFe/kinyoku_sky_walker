import 'package:flutter_test/flutter_test.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/prohibited_matter/monthly_carousel_time_service.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';
import 'package:mockito/mockito.dart';

class MockProhibitedMatterTimeRepository extends Mock
    implements ProhibitedMatterTimeRepository {}

void main() {
  group('prohibited time monthly carousel', () {
    test('to get weekly carousel data when pass empty input', () async {
      final allProhibitedMatterTimes = <ProhibitedMatterTime>[];

      final prohibitedMatterTimeMonthlyCarouselUseCase =
          MonthlyCarouselTimeService();
      final carouselData = prohibitedMatterTimeMonthlyCarouselUseCase
          .getWeeklyDividedProhibitedMatterTimes(
              prohibitedMatterTimes: allProhibitedMatterTimes);
      expect(carouselData, [
        [[]]
      ]);
    });

    test('let current month has one data, current month is 4 row', () async {
      final allProhibitedMatterTimes = [
        ProhibitedMatterTime(
            id: 1, hours: 1, minutes: 1, date: DateTime(2020, 9, 1))
      ];
      final prohibitedMatterTimeMonthlyCarouselUseCase =
          MonthlyCarouselTimeService();
      final carouselData = prohibitedMatterTimeMonthlyCarouselUseCase
          .getWeeklyDividedProhibitedMatterTimes(
              now: DateTime(2020, 9, 14),
              prohibitedMatterTimes: allProhibitedMatterTimes);
      expect(carouselData, [
        [allProhibitedMatterTimes, [], [], []]
      ]);
    });
  });
}
/*

      ProhibitedMatterTime(
          id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 1)),
      ProhibitedMatterTime(
          id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 8)),
      ProhibitedMatterTime(
          id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 15)),
      ProhibitedMatterTime(
          id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 22)),
 */

/*
culcurate monthly prohibted times where latest month is 2020/7',

    final repository = MockProhibitedMatterTimeRepository();
    when(repository.getAll()).thenAnswer((_) async => Future.value([
          ProhibitedMatterTime(
              id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 1)),
          ProhibitedMatterTime(
              id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 8)),
          ProhibitedMatterTime(
              id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 15)),
          ProhibitedMatterTime(
              id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 22)),
        ]));
    final allProhibitedMatterTimes = await repository.getAll();

    when(mockProhibitedMatterTimeMonthlyCarouselUseCase
            .getWeeklyDividedProhibitedMatterTimes(allProhibitedMatterTimes))
        .thenReturn([
      [
        ProhibitedMatterTime(
            id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 1, 1))
      ],
      [
        ProhibitedMatterTime(
            id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 8, 1))
      ],
      [
        ProhibitedMatterTime(
            id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 15, 1))
      ],
      [
        ProhibitedMatterTime(
            id: 1, hours: 1, minutes: 1, date: DateTime(2020, 7, 22, 1))
      ],
    ]);
    final prohibitedMatterTimesForMonthlyCarousel =
        mockProhibitedMatterTimeMonthlyCarouselUseCase
            .getWeeklyDividedProhibitedMatterTimes(allProhibitedMatterTimes);
     */
/*
    final prohibitedMatterTimesForMonthlyCarousel =
        ProhibitedMatterTimeMonthlyCarouselUseCase()
            .getWeeklyDividedProhibitedMatterTimes(allProhibitedMatterTimes);

    final latestMonthWeekStartDays = [
      DateTime(2020, 7, 1).subtract(const Duration(seconds: 1)),
      DateTime(2020, 7, 8).subtract(const Duration(seconds: 1)),
      DateTime(2020, 7, 15).subtract(const Duration(seconds: 1)),
      DateTime(2020, 7, 22).subtract(const Duration(seconds: 1))
    ];
     */
/*
    for (var i = 0; i < 4; i++) {
      expect(
          latestMonthWeekStartDays[
                  prohibitedMatterTimesForMonthlyCarousel.length - i - 1]
              .isBefore(prohibitedMatterTimesForMonthlyCarousel[
                      prohibitedMatterTimesForMonthlyCarousel.length - i - 1][0]
                  .date),
          true);
      if (i != 0) {
        expect(
            prohibitedMatterTimesForMonthlyCarousel[
                    prohibitedMatterTimesForMonthlyCarousel.length - i - 1][0]
                .date
                .isBefore(latestMonthWeekStartDays[
                    prohibitedMatterTimesForMonthlyCarousel.length - i]),
            true);
      }
    }
     */
