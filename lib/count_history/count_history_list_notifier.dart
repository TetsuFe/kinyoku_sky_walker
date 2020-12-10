import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/count_history/count_history.dart';
import 'package:kinyoku_continue/count_history/count_history_repository.dart';

class CountHistoryListNotifier extends ValueNotifier<List<CountHistory>> {
  CountHistoryListNotifier(this.repository)
      : assert(repository != null),
        super([]) {
    reload();
  }

  final CountHistoryRepository repository;

  Future<void> reload() async {
    value = await repository.getAll();
  }
}

final ChangeNotifierProvider<CountHistoryListNotifier>
    countHistoryListNotifierProvider = ChangeNotifierProvider(
        (ref) => CountHistoryListNotifier(CountHistoryRepository()));

class CountHistoryTop5ListNotifier with ChangeNotifier {
  CountHistoryTop5ListNotifier(this.repository) : assert(repository != null) {
    reload();
  }

  final CountHistoryRepository repository;
  List<CountHistory> countHistoryTop5List;

  Future<void> reload() async {
    countHistoryTop5List = await repository.getLongestTop5();
    notifyListeners();
  }
}

final ChangeNotifierProvider<CountHistoryTop5ListNotifier>
    countHistoryTop5ListNotifierProvider = ChangeNotifierProvider(
        (ref) => CountHistoryTop5ListNotifier(CountHistoryRepository()));
