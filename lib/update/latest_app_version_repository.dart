import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class LatestAppVersionRepository {
  Future<int> get() async {
    final remoteConfig = await RemoteConfig.instance;
    if (Platform.isIOS) {
      try {
        await remoteConfig.fetch(expiration: const Duration(minutes: 0));
        await remoteConfig.activateFetched();
        print(remoteConfig.getInt('ios_app_build_number'));
        return remoteConfig.getInt('ios_app_build_number');
      } on Exception catch (e) {
        print(e.toString());
        print('error');
        return 0;
      }
    } else if (Platform.isAndroid) {
      try {
        await remoteConfig.fetch(expiration: const Duration(minutes: 0));
        await remoteConfig.activateFetched();
        // print(remoteConfig.getInt('android_app_build_number'));
        return remoteConfig.getInt('android_app_build_number');
      } on Exception catch (e) {
        print(e.toString());
        print('error');
        return 0;
      }
    } else {
      print('error');
      return 0;
    }
  }
}
