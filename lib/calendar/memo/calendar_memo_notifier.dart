import 'package:flutter/material.dart';
import 'package:kinyoku_continue/calendar/memo/memo_repository.dart';
import 'package:meta/meta.dart';

import 'models/memo.dart';

class CalendarMemoNotifier extends ValueNotifier<Memo> {
  CalendarMemoNotifier({@required this.repository}) : super(null);

  final MemoRepository repository;
}
