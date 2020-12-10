import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:kinyoku_continue/admob/banner_ad_height.dart';
import 'package:meta/meta.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with RouteAware {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  void didPush() {
    analytics.setCurrentScreen(
        screenName: ModalRoute.of(context).settings.name,
        screenClassOverride: widget.toString());
  }

  @override
  void didPopNext() {
    analytics.setCurrentScreen(
        screenName: ModalRoute.of(context).settings.name,
        screenClassOverride: widget.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<Object>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HelpPageBody();
  }
}

class HelpPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const BannerADSpacer(),
          AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
            title: const Text(
              '使い方',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                32,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    Text(
                      '1. インストール後、まずは必ずリセットボタンを押してください。',
                    ),
                    All16PaddingImage(
                      imagePath: 'assets/help/first_reset/step1.png',
                    ),
                    SizedBox(height: 32),
                    Text(
                      '2. リセットボタンを押すとダイアログが開きますので、リセット時刻（禁欲を開始した時刻）を入力してください。'
                      '正確な時刻でなくても結構です。',
                    ),
                    All16PaddingImage(
                      imagePath: 'assets/help/first_reset/step2.png',
                    ),
                    SizedBox(height: 32),
                    Text(
                      '3. 禁欲継続時間（禁欲の発散に費やした時間）を入力してください。'
                      '禁欲継続時間に関しては、記録の必要がない方は0時間0分としていただくこともできます。',
                    ),
                    All16PaddingImage(
                      imagePath: 'assets/help/first_reset/step3.png',
                    ),
                    SizedBox(height: 32),
                    Text('4. 入力が終わりましたら、確認ボタンを押してください。'),
                    All16PaddingImage(
                      imagePath: 'assets/help/first_reset/step4.png',
                    ),
                    SizedBox(height: 32),
                    Text('5. 確認のダイアログが出ますので、OKを押してください。'),
                    All16PaddingImage(
                      imagePath: 'assets/help/first_reset/step5.png',
                    ),
                    SizedBox(height: 32),
                    Text('6. 禁欲継続時間を共有しますか？というダイアログが出ますが、初回は無視していただいて結構です。'),
                    All16PaddingImage(
                      imagePath: 'assets/help/first_reset/step6.png',
                    ),
                    SizedBox(height: 32),
                    Text('7. リセットが完了すると画面上の数字もリセットされ、カウントが開始されます。'
                        '禁欲の開始時刻はアプリを閉じた後も保存されていますので、アプリは安心して閉じていただくことができます。'),
                    All16PaddingImage(
                      imagePath: 'assets/help/first_reset/step7.png',
                    ),
                    SizedBox(height: 32),
                    Text('基本的にはリセットするたびにこの操作の繰り返しとなります。'
                        'その他の機能に関しては禁欲の記録を見返したりシェアしたりする補助機能となっております。'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class All16PaddingImage extends StatelessWidget {
  const All16PaddingImage({@required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        16,
      ),
      child: Image.asset(imagePath),
    );
  }
}
