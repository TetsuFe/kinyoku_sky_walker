# kinyoku_sky_walker
禁煙・禁酒などの禁欲日数を記録でき、禁欲のモチベーション向上に役立つアプリです。
一般の方は以下のストアから最新アプリをダウンロードしてください。

[App Storeへのリンク](https://apps.apple.com/jp/app/id1524444519)
[Google Playへのリンク](https://play.google.com/store/apps/details?id=dev.tetsufe.kinyoku_continue&hl=ja)

こちらは最新のソースコードではありません。また、一部Firebase関連の部分は改変してあります。

## Build & Run
This project use dart-define. So must use dart-define when build and run.

### development environment

$ flutter build ios --debug --dart-define=BUNDLE_ID_SUFFIX=Dev --dart-define=FIREBASE_ENV=dev

### production environment

$ flutter build ios --release --dart-define=FIREBASE_ENV=prod

### run
$ fvm flutter run -d "<device_id>" --dart-define=BUILD_ENV=dev --dart-define=BUNDLE_ID_SUFFIX=Dev --dart-define=APP_SUFFIX=dev

## Code Generate
$ fvm flutter pub pub run build_runner build --delete-conflicting-outputs
