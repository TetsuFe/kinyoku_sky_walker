import 'package:flutter/material.dart';
import 'package:kinyoku_continue/update/check_update_service.dart';
import 'package:kinyoku_continue/update/latest_app_version_repository.dart';
import 'package:kinyoku_continue/update/update_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'latest_noticed_version_key.dart';

class NoticeUpdateService {
  final checkUpdateService =
      CheckUpdateService(repository: LatestAppVersionRepository());

  void showUpdateDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => UpdateDialog());
  }

  Future<void> showDialogIfNotLatestVersion(BuildContext context) async {
    final isLatestVersion = await checkUpdateService.isLatestVersion();
    print(isLatestVersion);
    if (!isLatestVersion) {
      final latestVersion = await checkUpdateService.getLatestVersion();
      saveLatestNoticedVersion(latestVersion);
      showUpdateDialog(context);
    }
  }

  Future<void> saveLatestNoticedVersion(int latestNoticeVersion) async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(latestNoticedVersionKey, latestNoticeVersion);
  }
}
