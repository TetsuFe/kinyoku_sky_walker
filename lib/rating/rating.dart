import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinyoku_continue/analytics/firebase_custom_analytics.dart';
import 'package:rate_my_app/rate_my_app.dart';

final analyticsService = AnalyticsService();

const googlePlayIdentifier = 'dev.tetsufe.kinyoku_continue';
const appStoreIdentifier = '1524444519';

RateMyApp createInstanceRating() {
  return RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 10,
    minLaunches: 5,
    remindDays: 10,
    remindLaunches: 5,
    googlePlayIdentifier: googlePlayIdentifier,
    appStoreIdentifier: appStoreIdentifier,
  );
}

void initializeRateMyAppDialog(BuildContext context) async {
  final rateMyApp = createInstanceRating();
  rateMyApp.init().then((_) {
    if (rateMyApp.shouldOpenDialog) {
      showStarRateDialog(rateMyApp, context);
    }
  });
}

Future<void> showStarRateDialog(
    RateMyApp rateMyApp, BuildContext context) async {
  analyticsService.sendRateMyAppDialogOpenedEvent();
  rateMyApp.showStarRateDialog(
    context,
    title: 'レビューのお願い',
    message: 'レビューをいただけると開発者のやる気が上がり、アップデートが頻度が高くなります☺️',
    actionsBuilder: (context, stars) {
      return [
        FlatButton(
          child: const Text('送信'),
          onPressed: () async {
            await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
            analyticsService.sendRateMyAppDialogSentEvent();
            Navigator.pop<RateMyAppDialogButton>(
                context, RateMyAppDialogButton.rate);
          },
        ),
      ];
    },
    ignoreNativeDialog: false,
    dialogStyle: const DialogStyle(
      titleAlign: TextAlign.center,
      messagePadding: EdgeInsets.only(bottom: 20),
    ),
    starRatingOptions: const StarRatingOptions(),
    onDismissed: () {
      analyticsService.sendRateMyAppDialogDisposedEvent();
      return rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed);
    },
  );
}
