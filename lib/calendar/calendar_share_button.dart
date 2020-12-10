import 'package:flutter/material.dart';
import 'package:kinyoku_continue/share/share.dart';

import 'calendar_page.dart';

class CalendarShareButton extends StatelessWidget {
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
            CalenarShareProvider()
                .openPlatformShareTextAndImageDialogForCalender(calendarKey);
          },
          icon: const Icon(
            Icons.share,
          ),
        ),
      ),
      const Text(
        ' シェア ',
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }
}

class CalenarShareProvider extends ShareProvider {
  void openPlatformShareTextAndImageDialogForCalender(GlobalKey globalKey) {
    openPlatformShareTextAndImageDialog(
        '今月の禁欲カレンダーです。\n@kinyoku_support', globalKey);
  }
}
