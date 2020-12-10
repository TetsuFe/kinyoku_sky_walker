import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:meta/meta.dart';

enum AnalyticsEvent {
  rateMyAppDialogDisposed,
  rateMyAppDialogSent,
  rateMyAppDialogOpened,
}

class AnalyticsService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics();
  static final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  /// レーティングダイアログキャンセルイベント送信
  Future<void> sendRateMyAppDialogDisposedEvent() async {
    sendEvent(
      event: AnalyticsEvent.rateMyAppDialogDisposed,
    );
  }

  /// レーティングダイアログ送信イベント送信
  Future<void> sendRateMyAppDialogSentEvent() async {
    sendEvent(
      event: AnalyticsEvent.rateMyAppDialogSent,
    );
  }

  /// レーティングダイアログ表示イベント送信
  Future<void> sendRateMyAppDialogOpenedEvent() async {
    sendEvent(
      event: AnalyticsEvent.rateMyAppDialogOpened,
    );
  }

  /// イベントを送信する
  /// [event] AnalyticsEvent
  /// [parameterMap] パラメータMap
  Future<void> sendEvent(
      {@required AnalyticsEvent event,
      Map<String, dynamic> parameterMap}) async {
    final eventName = event.toString().split('.')[1];
    analytics.logEvent(name: eventName, parameters: parameterMap);
  }
}
