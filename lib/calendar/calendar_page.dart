import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/calendar/calendar_usecase.dart';
import 'package:kinyoku_continue/calendar/calender_prohibited_mark_notifier.dart';
import 'package:kinyoku_continue/calendar/custom_calendar_carousel.dart';
import 'package:kinyoku_continue/calendar/memo/memo_view.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';

import 'calendar_share_button.dart';

final calendarKey = GlobalKey();

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate;
  var _markedDateMap = EventList<Event>();
  final _useCase =
      CalenderUseCase(repository: ProhibitedMatterTimeRepository());

  Future<void> initProhibitedAndNotMark(
      List<DateTime> allProhibitedMatterDays) async {
    _markedDateMap = await _useCase.getMarkedDateMap(allProhibitedMatterDays);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calenderProhibitedMarkDaysNotifierProvider.read(context)
      ..addListener(initProhibitedAndNotMark)
      ..reload();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RepaintBoundary(
          key: calendarKey,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomCalendarCarousel(
              onDayPressed: (DateTime date, List<Event> events) {
                setState(() => _selectedDate = date);
                print(date);
              },
              markedDateMap: _markedDateMap,
              selectedDate: _selectedDate,
            ),
          ),
        ),
        MemoView(
          calendarDate: _selectedDate ?? DateTime.now(),
          onSubmitCompleted: () {
            setState(() {});
          },
        ),
        ...buildCalendarSubInfo(),
      ]),
    );
  }
}

List<Widget> buildCalendarSubInfo() {
  return [
    Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Align(
        alignment: Alignment.topRight,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.green,
              ),
              child: const SizedBox(
                height: 16,
                width: 16,
              )),
          const Text('禁欲成功日'),
          const SizedBox(
            width: 16,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.red,
              ),
              child: const SizedBox(
                height: 16,
                width: 16,
              )),
          const Text('禁欲失敗日'),
          const SizedBox(width: 16),
          CalendarShareButton(),
        ]),
      ),
    ),
  ];
}
