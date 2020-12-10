import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:kinyoku_continue/admob/banner_ad_height.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';

class FakeAdMobService implements AdMobService {
  @override
  // ignore: unused_element
  String _appId() {
    return '';
  }

  @override
  // ignore: unused_element
  String _unitId() {
    return '';
  }

  @override
  void init() {}

  @override
  // ignore: unused_field
  BannerAd _banner;

  @override
  void showBanner() {}
}

class DevAdMobService implements AdMobService {
  @override
  DevAdMobService() {
    _banner = AdMobBannerFactory().createBanner(_unitId());
  }

  @override
  BannerAd _banner;

  @override
  String _appId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-***';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-***';
    } else {
      return '';
    }
  }

  @override
  String _unitId() {
    return BannerAd.testAdUnitId;
  }

  @override
  void init() {
    // FirebaseAdMob.instance.initialize(appId: _appId());
    FirebaseAdMob.instance.initialize(appId: _appId());
  }

  @override
  void showBanner() {
    _banner
      ..load()
      ..show(
        anchorOffset: bannerADHeight,
        anchorType: AnchorType.top,
      );
  }
}

abstract class AdMobService {
  // ignore: unused_field
  BannerAd _banner;

  // ignore: unused_element
  String _appId();
  // ignore: unused_element
  String _unitId();
  void init();
  void showBanner();
}

class ProdAdMobService implements AdMobService {
  ProdAdMobService() {
    _banner = AdMobBannerFactory().createBanner(_unitId());
    // _banner = AdMobBannerFactory().createBanner(BannerAd.testAdUnitId);
  }

  @override
  BannerAd _banner;

  @override
  String _appId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-***';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-***';
    } else {
      return '';
    }
  }

  @override
  String _unitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-***';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-***';
    } else {
      return '';
    }
  }

  @override
  void init() {
    // FirebaseAdMob.instance.initialize(appId: _appId());
    FirebaseAdMob.instance.initialize(appId: _appId());
  }

  @override
  void showBanner() {
    _banner
      ..load()
      ..show(
        anchorOffset: bannerADHeight,
        anchorType: AnchorType.top,
      );
  }
}

class AdMobBannerFactory {
  // 広告ターゲット
  MobileAdTargetingInfo createTargetingInfo() => const MobileAdTargetingInfo(
        keywords: <String>[
          '筋トレ',
          'ダイエット',
          'ランニング',
          'アドブロック',
          '広告ブロック',
          'ダンベル',
          'ニキビ',
          'プロアクティブ',
          '洗顔',
          'マインドフルネス',
          '座禅',
          '瞑想',
        ],
        childDirected: false,
        testDevices: <String>['9AC530AD7DADDB5CDDEF222B7D84BF28'],
      );

  BannerAd createBanner(String adUnitId) {
    print(adUnitId);
    final targetingInfo = createTargetingInfo();
    return BannerAd(
      adUnitId: adUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
  }
}

class AdMobInterstitialFactory {
  // 広告ターゲット
  MobileAdTargetingInfo createTargetingInfo() => const MobileAdTargetingInfo(
        keywords: <String>[
          '筋トレ',
          'ダイエット',
          'ランニング',
          'アドブロック',
          '広告ブロック',
          'ダンベル',
          'ニキビ',
          'プロアクティブ',
          '洗顔',
          'マインドフルネス',
          '座禅',
          '瞑想',
        ],
        childDirected: false,
        testDevices: <String>['9AC530AD7DADDB5CDDEF222B7D84BF28'],
      );

  InterstitialAd createAd(String adUnitId) {
    print(adUnitId);
    final targetingInfo = createTargetingInfo();
    return InterstitialAd(
      adUnitId: adUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
  }
}

abstract class AdMobInterstitialService {
  // ignore: unused_field
  InterstitialAd _ad;

  // ignore: unused_element
  String _appId();
  // ignore: unused_element
  String _unitId();
  void init();
  void showAd();
}

class ProdAdMobInterstitialService implements AdMobInterstitialService {
  ProdAdMobInterstitialService() {
    _ad = AdMobInterstitialFactory().createAd(_unitId());
  }

  @override
  InterstitialAd _ad;

  @override
  String _appId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-***';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-***';
    } else {
      return '';
    }
  }

  @override
  String _unitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-***';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-***';
    } else {
      return '';
    }
  }

  @override
  void init() {
    // FirebaseAdMob.instance.initialize(appId: _appId());
    FirebaseAdMob.instance.initialize(appId: _appId());
  }

  @override
  void showAd() {
    _ad
      ..load()
      ..show(
        anchorOffset: bannerADHeight,
        anchorType: AnchorType.top,
      );
  }
}

class DevAdMobInterstitialService implements AdMobInterstitialService {
  @override
  DevAdMobInterstitialService() {
    _ad = AdMobInterstitialFactory().createAd(_unitId());
  }

  @override
  InterstitialAd _ad;

  @override
  String _appId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-***';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-***';
    } else {
      return '';
    }
  }

  @override
  String _unitId() {
    return InterstitialAd.testAdUnitId;
  }

  @override
  void init() {
    // FirebaseAdMob.instance.initialize(appId: _appId());
    FirebaseAdMob.instance.initialize(appId: _appId());
  }

  @override
  void showAd() {
    _ad
      ..load()
      ..show(
        anchorOffset: bannerADHeight,
        anchorType: AnchorType.top,
      );
  }
}

class AdScheduler {
  final key = 'adSchedulerLastTimeKey';
  bool isAdOk() {
    final adSchedulerLastTimeString = sharedPreference.getString(key);
    if (adSchedulerLastTimeString == null) {
      sharedPreference.setString(key, DateTime.now().toIso8601String());
    } else {
      final adSchedulerLastTime = DateTime.parse(adSchedulerLastTimeString);
      final isPeriodExceeded =
          DateTime.now().difference(adSchedulerLastTime).inDays >= 3;
      if (isPeriodExceeded) {
        sharedPreference.setString(key, DateTime.now().toIso8601String());
        return true;
      }
    }
    return false;
  }
}
