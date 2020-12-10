import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class CustomCalendarCarousel extends StatelessWidget {
  const CustomCalendarCarousel({
    @required this.onDayPressed,
    @required this.markedDateMap,
    @required this.selectedDate,
  });

  final Function(DateTime date, List<Event> events) onDayPressed;
  final EventList<Event> markedDateMap;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return CalendarCarousel<Event>(
      onDayPressed: onDayPressed,
      showIconBehindDayText: true,
      markedDateIconMaxShown: 5,
      markedDateIconBuilder: (event) => Center(
        child: Container(
          margin: const EdgeInsets.only(top: 3),
          width: 30,
          height: 30,
          child: event.getIcon(),
        ),
      ),
      headerTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
      weekdayTextStyle: const TextStyle(color: Colors.white),
      weekendTextStyle: const TextStyle(
        color: Colors.deepOrange,
      ),
      daysTextStyle: const TextStyle(
        color: Colors.white,
      ),
      thisMonthDayBorderColor: Colors.grey,
      todayButtonColor: Theme.of(context).primaryColor,
      todayBorderColor: Theme.of(context).primaryColor,
      selectedDayButtonColor: Colors.orange,
      selectedDayBorderColor: Colors.orange,
      weekFormat: false,
      markedDatesMap: markedDateMap,
      height: mediaQuery.size.width * 20 / 19,
      selectedDateTime: selectedDate,
      daysHaveCircularBorder: false,
      locale: 'ja_JP',
      onDayLongPressed: (time) {},
    );
  }
}

/*
      customDayBuilder: (
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        if (day.day == 15) {
          return const Center(
            child: Icon(Icons.local_airport),
          );
        } else {
          return null;
        }
      },
 */
