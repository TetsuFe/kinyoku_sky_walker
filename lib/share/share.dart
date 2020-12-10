import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:kinyoku_continue/share/convert_widget_to_image.dart';
import 'package:meta/meta.dart';

const twitterAccountIdWithAtmark = '@kinyoku_support';

class ShareProvider {
  @protected
  Future<void> openPlatformShareTextAndImageDialog(
      String text, GlobalKey globalKey) async {
    final bytes = await WidgetToImageConverter().exportToImage(globalKey);
    await Share.file(
        'shared image', 'share.png', bytes.buffer.asUint8List(), 'image/png',
        text: text);
  }

  @protected
  Future<void> openPlatformShareTextDialog(String text) async {
    Share.text(text, text, 'text/plain');
  }

  Future<void> openPlatformShareDialogForCurrentElapsedTime(
      ElapsedTime elapsedTime, GlobalKey globalKey) async {
    await openPlatformShareTextAndImageDialog(
        '禁欲を${elapsedTime.inDays}日と${elapsedTime.inHours}時間'
        '${elapsedTime.inMinutes}分継続中！\n'
        '#禁欲スカイウォーカー $twitterAccountIdWithAtmark',
        globalKey);
    return;
  }

  Future<void> openPlatformShareDialogForElapsedTimeAtReset(
      ElapsedTime elapsedTime) async {
    await openPlatformShareTextDialog(
        'リセットしました。今回の禁欲継続時間は${elapsedTime.inDays}日と${elapsedTime.inHours}時間'
        '${elapsedTime.inMinutes}分でした。\n'
        '$twitterAccountIdWithAtmark\n'
        '${appUrl()}');
    return;
  }

  Future<void> openPlatformShareDialogForElapsedTimeWithoutImage(
      ElapsedTime elapsedTime) async {
    await openPlatformShareTextDialog(
        '禁欲を${elapsedTime.inDays}日と${elapsedTime.inHours}時間'
        '${elapsedTime.inMinutes}分継続中！\n'
        '$twitterAccountIdWithAtmark\n'
        '${appUrl()}');
    return;
  }

  @protected
  String appUrl() {
    // ignore: lines_longer_than_80_chars
    return '${Platform.isIOS ? 'https://apps.apple.com/jp/app/id1524444519' : 'https://play.google.com/store/apps/details?id=dev.tetsufe.kinyoku_continue'}';
  }
}
