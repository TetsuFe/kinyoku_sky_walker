import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class CountHistory {
  CountHistory(
      {this.id,
      @required this.days,
      @required this.hours,
      @required this.minutes,
      @required this.seconds,
      @required this.date});

  factory CountHistory.fromJson(Map<String, dynamic> json) => CountHistory(
        id: json['id'] as int,
        days: json['days'] as int,
        hours: json['hours'] as int,
        minutes: json['minutes'] as int,
        seconds: json['seconds'] as int,
        date: DateTime.parse(json['date'] as String).toLocal(),
      );

  final int id;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final DateTime date;

  /// AutoIncrementを使うため、idは必要ない
  Map<String, dynamic> toJsonWithoutId() => {
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds,
        'date': date.toUtc().toIso8601String(),
      };

  String get daysWithUnit => '$days日';
  String get hoursWithUnit => '$hours時間';
  String get minutesWithUnit => '$minutes分';
  String get secondsWithUnit => '$seconds秒';

  String formattedDate() {
    initializeDateFormatting('ja_JP');
    return '${DateFormat('yyyy/MM/dd(E)', 'ja_JP').format(date)}';
  }
}
