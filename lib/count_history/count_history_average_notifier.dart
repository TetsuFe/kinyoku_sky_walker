import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/count_history/count_history_repository.dart';

class CountHistoryAverageNotifier with ChangeNotifier {
  CountHistoryAverageNotifier(this.repository) : assert(repository != null) {
    reload();
  }

  final CountHistoryRepository repository;
  CountAverage countHistoryAverage;

  Future<void> reload() async {
    countHistoryAverage = await repository.averageCount();
    notifyListeners();
  }
}

final ChangeNotifierProvider<CountHistoryAverageNotifier>
    countHistoryAverageNotifierProvider = ChangeNotifierProvider(
        (ref) => CountHistoryAverageNotifier(CountHistoryRepository()));
