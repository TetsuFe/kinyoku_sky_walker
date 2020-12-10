import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/supplemental_count/widgets/reset_info_form_dialog.dart';

class SupplementalCounterResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Consumer((context, read) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => SupplementalResetInfoFormDialog(),
              );
              /*
              showDialog(
                context: context,
                builder: (context) => ConfirmToResetDialog(
                    title: '本当にリセットしますか？', okAction: elapsedTimeNotifier.reset),
              );
               */
            },
            icon: const Icon(
              Icons.power_settings_new,
            ),
          ),
        );
      }),
      const Text(
        '　　リセット　　',
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }
}
