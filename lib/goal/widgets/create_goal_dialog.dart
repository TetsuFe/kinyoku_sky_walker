import 'package:flutter/material.dart';
import 'package:kinyoku_continue/goal/widgets/create_goal_form.dart';

class CreateGoalDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(
        '目標日数設定',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      children: [
        CreateGoalForm(),
      ],
    );
  }
}
