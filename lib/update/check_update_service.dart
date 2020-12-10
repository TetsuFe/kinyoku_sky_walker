import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'latest_app_version_repository.dart';
import 'latest_noticed_version_key.dart';

class CheckUpdateService {
  CheckUpdateService({@required this.repository});
  LatestAppVersionRepository repository;
  Future<bool> isLatestVersion() async {
    final versionInMyDevice = PackageInfo().buildNumber != null
        ? int.parse(PackageInfo().buildNumber)
        : 1;
    print(PackageInfo().buildNumber);
    print(versionInMyDevice);
    final latestVersion = await getLatestVersion();
    print(latestVersion);
    final latestNoticedVersion = await getLatestNoticedVersion();
    // 初回のチェック（インストール後一回目）
    if (latestNoticedVersion == null) {
      // 本来は return versionInMyDevice >= latestVersion; だが、
      // remote configの影響か不安定なので、最新版になっているとして処理
      return true;
    }
    print(latestNoticedVersion);
    print(latestNoticedVersion < latestVersion);
    return versionInMyDevice >= latestVersion ||
        latestNoticedVersion >= latestVersion;
  }

  Future<int> getLatestVersion() async {
    return repository.get();
  }

  Future<int> getLatestNoticedVersion() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(latestNoticedVersionKey);
  }
}
