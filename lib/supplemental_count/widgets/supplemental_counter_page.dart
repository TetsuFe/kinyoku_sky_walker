import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/admob/banner_ad_height.dart';
import 'package:kinyoku_continue/supplemental_count/supplemental_label/models/goal_notifier.dart';
import 'package:kinyoku_continue/supplemental_count/supplemental_label/widgets/goal_setting_button.dart';
import 'package:kinyoku_continue/supplemental_count/widgets/date_counter_reset_button.dart';
import 'package:kinyoku_continue/supplemental_count/widgets/date_counter_widget.dart';

class SupplementalCounterPage extends StatelessWidget {
  const SupplementalCounterPage();
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
              '補助カウンター',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Widgetを画像としてシェアするためにこのようにRepaintBoundaryしこんだり、
                  // SizedBoxを違和感のある位置においたりしている
                  Consumer((ref, read) {
                    final label =
                        read(supplementalLabelNotifierProvider).label.text;
                    return Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          SupplementalDateCounterWidget(
                            supplementalLabel: '$label',
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SupplementalCounterResetButton(),
                      UpdateSupplementalLabelButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
