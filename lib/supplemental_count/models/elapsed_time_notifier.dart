import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/counter/models/count_start_date.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:kinyoku_continue/supplemental_count/count_start_date_repository.dart';

class SupplementalElapsedTimeNotifier with ChangeNotifier {
  SupplementalElapsedTimeNotifier(this.repository)
      : assert(repository != null) {
    initializeElapsedTime();
    fire();
  }

  CountStartDate _countStartDate;
  ElapsedTime elapsedTime;
  final SupplementalCountStateDateRepository repository;

  void initializeElapsedTime() {
    _countStartDate =
        repository.read() ?? CountStartDate(value: DateTime.now());
    elapsedTime = ElapsedTime(DateTime.now().difference(_countStartDate.value));
  }

  void fire() {
    Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        elapsedTime =
            ElapsedTime(DateTime.now().difference(_countStartDate.value));
        notifyListeners();
      },
    );
  }

  void reset(DateTime resetDate) {
    initializeElapsedTime();
    fire();
    notifyListeners();
  }
}

final ChangeNotifierProvider<SupplementalElapsedTimeNotifier>
    supplementalElapsedTimeNotifierProvider = ChangeNotifierProvider((ref) =>
        SupplementalElapsedTimeNotifier(
            SupplementalCountStateDateRepository()));
