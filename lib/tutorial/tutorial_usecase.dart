import 'package:flutter/material.dart';
import 'package:kinyoku_continue/tutorial/tutorial_dialog.dart';
import 'package:kinyoku_continue/tutorial/tutorial_repository.dart';

class TutorialUseCase {
  static TutorialUseCase instance = TutorialUseCase();
  final repository = TutorialRepository();
  bool isdialogShown = false;

  void showTutorialIfUserDidNotReset(BuildContext context) {
    if (repository.isNotReset()) {
      if (!isdialogShown) {
        showDialog(
          context: context,
          builder: (context) => TurorialDialog(),
        );
        isdialogShown = true;
      }
      /*
      final overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return TurorialDialog();
        },
      );
      Navigator.of(context).overlay.insert(overlayEntry);
       */
    }
  }
}
