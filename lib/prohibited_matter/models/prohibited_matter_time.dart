import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class ProhibitedMatterTime {
  ProhibitedMatterTime(
      {this.id,
      @required this.hours,
      @required this.minutes,
      @required this.date})
      : assert(hours != null, minutes != null);

  factory ProhibitedMatterTime.fromJson(Map<String, dynamic> json) =>
      ProhibitedMatterTime(
        id: json['id'] as int,
        hours: json['hours'] as int,
        minutes: json['minutes'] as int,
        date: DateTime.parse(json['date'] as String).toLocal(),
      );

  final int id;
  final int hours;
  final int minutes;
  final DateTime date;

  /// AutoIncrementを使うため、idは必要ない
  Map<String, dynamic> toJsonWithoutId() => {
        'hours': hours,
        'minutes': minutes,
        'date': date.toUtc().toIso8601String(),
      };

  String get hoursWithUnit => '$hours時間';
  String get minutesWithUnit => '$minutes分';

  String formattedDate() {
    initializeDateFormatting('ja_JP');
    return '${DateFormat('yyyy/MM/dd(E)', 'ja_JP').format(date)}';
  }
}
