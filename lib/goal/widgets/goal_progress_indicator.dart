import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time_notifier.dart';
import 'package:kinyoku_continue/goal/models/goal_notifier.dart';

class GoalProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer((context, read) {
      final goalDays = read(goalNotifierProvider).goal.days;
      final currentDays =
          read(elapsedTimeNotifierProvider).getElapsedTime().inDays;
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: LinearProgressIndicator(
              value: currentDays / goalDays,
              backgroundColor: Colors.blueGrey,
            ),
          ),
          Text(
            goalDays - currentDays > 0
                ? '目標達成($goalDays日)まで残り${goalDays - currentDays}日！'
                : '目標達成中！($currentDays / $goalDays日)',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      );
    });
  }
}
