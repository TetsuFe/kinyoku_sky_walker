import 'package:flutter/material.dart';
import 'package:kinyoku_continue/supplemental_count/supplemental_label/widgets/create_goal_form.dart';

class UpdateSupplementalLabelDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(
        '補助カウンター名設定',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      children: [
        UpdateSupplementalLabelForm(),
      ],
    );
  }
}
