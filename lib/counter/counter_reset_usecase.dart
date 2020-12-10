import 'package:flutter/material.dart';
import 'package:kinyoku_continue/count_history/count_history.dart';
import 'package:kinyoku_continue/count_history/count_history_repository.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:kinyoku_continue/share/share.dart';

class CounterResetUseCase {
  void execute(ElapsedTime elapsedTime, DateTime resetDate) {
    final newCountHistory = CountHistory(
      days: elapsedTime.inDays,
      hours: elapsedTime.inHours,
      minutes: elapsedTime.inMinutes,
      seconds: elapsedTime.inSeconds,
      date: resetDate,
    );
    CountHistoryRepository().create(newCountHistory);
  }

  Future<void> shareElapsedTimeAtReset(
      ElapsedTime elapsedTime, Size size) async {
    return ShareProvider()
        .openPlatformShareDialogForElapsedTimeAtReset(elapsedTime);
  }
}
