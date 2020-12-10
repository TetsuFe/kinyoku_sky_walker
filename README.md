# kinyoku_continue

[![codecov](https://codecov.io/gh/TetsuFe/kinyoku_continue/branch/master/graph/badge.svg?token=8PNZBD3F21)](https://codecov.io/gh/TetsuFe/kinyoku_continue)

modern 禁欲 support app

## Build & Run
This project use dart-define. So must use dart-define when build and run.

development environment

$ flutter build ios --debug --dart-define=BUNDLE_ID_SUFFIX=Dev --dart-define=FIREBASE_ENV=dev

production environment

$ flutter build ios --release --dart-define=FIREBASE_ENV=prod

### run
$ fvm flutter run -d "FAFD2D18-6F4E-4B9A-8E95-469F50378E7B" --dart-define=BUILD_ENV=dev --dart-define=BUNDLE_ID_SUFFIX=Dev --dart-define=APP_SUFFIX=dev

## Code Generate
$ fvm flutter pub pub run build_runner build --delete-conflicting-outputs
