import 'package:flutter/material.dart';
import 'package:kinyoku_continue/supplemental_count/supplemental_label/widgets/create_goal_dialog.dart';

class UpdateSupplementalLabelButton extends StatelessWidget {
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
              builder: (context) => UpdateSupplementalLabelDialog(),
            );
          },
          icon: const Icon(
            Icons.edit,
          ),
        ),
      ),
      const Text(
        'カウンター名変更',
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }
}
