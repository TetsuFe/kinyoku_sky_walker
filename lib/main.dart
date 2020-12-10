import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/admob/admob.dart';
import 'package:kinyoku_continue/root_page.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';
import 'package:kinyoku_continue/update/notice_update_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreference = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// 現状は、firebaseの設定のみに使う
const buildEnv = String.fromEnvironment('BUILD_ENV');

class _MyAppState extends State<MyApp> {
  final _admobService =
      buildEnv == 'prod' ? ProdAdMobService() : FakeAdMobService();
  final _admobInterstitialService = buildEnv == 'prod'
      ? ProdAdMobInterstitialService()
      : DevAdMobInterstitialService();

  Future<FirebaseApp> firebaseInited;

  void firebaseInit() async {
    firebaseInited = Firebase.initializeApp();
  }

  var _isUpdateChecked = false;

  /*
  _initMyRank() async {
    final user = await AuthFacade().signIn();
    // RankingApi().initMyRank(user.getId());
  }
   */

  @override
  void initState() {
    super.initState();
    firebaseInit();
    _admobService
      ..init()
      ..showBanner();
    if (AdScheduler().isAdOk()) {
      _admobInterstitialService
        ..init()
        ..showAd();
    }
    /*
    final reposirory = ProhibitedMatterTimeRepository();
    var p = ProhibitedMatterTime(
        id: 11, date: DateTime(2020, 8, 10, 1, 1), minutes: 0, hours: 1);
    reposirory.update(p);
    reposirory.getAll().then((value) => value.forEach((element) {
          print(element.toJsonWithoutId());
        }));
     */
    /*
    reposirory.update(ProhibitedMatterTime(id: , date: , minutes: ,hours: ));
    reposirory.update(ProhibitedMatterTime(id: , date: , minutes: ,hours: ));
    reposirory.update(ProhibitedMatterTime(id: , date: , minutes: ,hours: ));
    reposirory.update(ProhibitedMatterTime(id: , date: , minutes: ,hours: ));
     */
    /*
    reposirory.create(ProhibitedMatterTime(
        hours: 1, minutes: 30, date: DateTime(2020, 8, 1)));
    reposirory.create(ProhibitedMatterTime(
        hours: 1, minutes: 30, date: DateTime(2020, 7, 8)));
    reposirory.create(ProhibitedMatterTime(
        hours: 1, minutes: 30, date: DateTime(2020, 7, 15)));
     */
  }

  // final FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.blue[600];
    final accentColor = Colors.blue[600];
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white,
        ),
        primaryTextTheme: newTextTheme,
        //primarySwatch: Colors.lightBlue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: primaryColor,
        accentColor: accentColor,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: firebaseInited,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('エラーが発生しました。再度起動してください。');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (!_isUpdateChecked) {
                NoticeUpdateService().showDialogIfNotLatestVersion(context);
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  setState(() {
                    _isUpdateChecked = true;
                  });
                });
              }
              return RootPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
