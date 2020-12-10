class CalendarMemoDateAdapter {
  DateTime transferToMemoDate(DateTime calendarDate) {
    return DateTime(calendarDate.year, calendarDate.month, calendarDate.day);
  }
}
