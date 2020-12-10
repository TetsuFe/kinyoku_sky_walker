import 'package:flutter/material.dart';
import 'package:kinyoku_continue/goal/widgets/create_goal_dialog.dart';

class GoalSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => CreateGoalDialog(),
            );
          },
          icon: const Icon(
            Icons.trending_up,
          ),
        ),
      ),
      const Text(
        '目標設定',
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }
}
