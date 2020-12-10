import 'package:flutter/material.dart';

import '../get_title_share_provider.dart';

class GetTitleUseCase {
  static GetTitleUseCase instance = GetTitleUseCase();
  bool isDialogShown = false;
  void openShareConfirmDialog(
      BuildContext context, String titleName, int stoicDays) {
    if (!isDialogShown) {
      isDialogShown = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Text('称号「$titleName」を獲得しました。SNS等にシェアしますか？'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('いいえ'),
            ),
            FlatButton(
              onPressed: () {
                openShareDialog(stoicDays, titleName);
                Navigator.pop(context);
              },
              color: Colors.blue,
              child: const Text('はい'),
            ),
          ],
        ),
      );
    }
  }

  void openShareDialog(int stoicDays, String titleName) {
    GetTitleShareProvider()
        .openPlatformShareDialogForGetTitle(stoicDays, titleName);
  }
}
