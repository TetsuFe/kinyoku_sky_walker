import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/goal/models/goal.dart';

import '../goal_repository.dart';

class GoalNotifier with ChangeNotifier {
  GoalNotifier(this.repository) : assert(repository != null) {
    goal = repository.read();
  }

  final GoalRepository repository;
  Goal goal;

  void update(int goalDays) {
    repository.update(goalDays);
    goal = repository.read();
    notifyListeners();
  }
}

final ChangeNotifierProvider<GoalNotifier> goalNotifierProvider =
    ChangeNotifierProvider((ref) => GoalNotifier(GoalRepository()));
