import 'dart:io';

import 'package:flutter/material.dart';

const double bannerADHeight = 32;

class BannerADSpacer extends StatelessWidget {
  const BannerADSpacer();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Platform.isIOS ? bannerADHeight + 32 : bannerADHeight);
  }
}
