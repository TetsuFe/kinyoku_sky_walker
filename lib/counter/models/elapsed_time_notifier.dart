import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/counter/count_start_date_repository.dart';
import 'package:kinyoku_continue/counter/counter_reset_usecase.dart';
import 'package:kinyoku_continue/counter/models/count_start_date.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:kinyoku_continue/reset/reset_api.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

class ElapsedTimeNotifier with ChangeNotifier {
  ElapsedTimeNotifier(this.repository) : assert(repository != null) {
    //repository.reset(DateTime.utc(2020, 7, 20));
    initializeElapsedTime();

    // 初回リセット後(!=null)のみ、タイマーが動く
    if (repository.read() != null) {
      fire();
    }
  }

  CountStartDate _countStartDate;
  ElapsedTime _elapsedTime;
  final CountStateDateRepository repository;

  void initializeElapsedTime() {
    _countStartDate =
        repository.read() ?? CountStartDate(value: DateTime.now());
    _elapsedTime =
        ElapsedTime(DateTime.now().difference(_countStartDate.value));
  }

  ElapsedTime getElapsedTime() => _elapsedTime;

  void fire() {
    Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _elapsedTime =
            ElapsedTime(DateTime.now().difference(_countStartDate.value));
        notifyListeners();
      },
    );
  }

  void reset(DateTime resetDate) {
    CounterResetUseCase().execute(_elapsedTime, resetDate);
    initializeElapsedTime();
    fire();
    notifyListeners();
  }
}

final ChangeNotifierProvider<ElapsedTimeNotifier> elapsedTimeNotifierProvider =
    ChangeNotifierProvider((ref) => ElapsedTimeNotifier(
        CountStateDateRepository(
            resetApi: ref.read(resetApiProvider),
            sharedPreferences: sharedPreference)));
