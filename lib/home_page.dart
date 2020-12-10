import 'package:flutter/material.dart';
import 'package:kinyoku_continue/chat/chat_link_button.dart';
import 'package:kinyoku_continue/counter/widgets/date_counter_widget.dart';
import 'package:kinyoku_continue/goal/widgets/goal_progress_indicator.dart';
import 'package:kinyoku_continue/goal/widgets/goal_setting_button.dart';
import 'package:kinyoku_continue/help/help_button.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';
import 'package:kinyoku_continue/share/global_keys.dart';
import 'package:kinyoku_continue/share/widgets/platform_share_button.dart';
import 'package:kinyoku_continue/supplemental_count/widgets/supplemental_counter_button.dart';
import 'package:kinyoku_continue/tutorial/tutorial_usecase.dart';

import 'counter/widgets/date_counter_reset_button.dart';

class HomePage extends StatelessWidget {
  const HomePage();
  static final tutorialUseCase = TutorialUseCase.instance;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      tutorialUseCase.showTutorialIfUserDidNotReset(context);
    });
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Widgetを画像としてシェアするためにこのようにRepaintBoundaryしこんだり、
            // SizedBoxを違和感のある位置においたりしている
            RepaintBoundary(
              key: key,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const DateCounterWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    SwitchableProgressIndicator(),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DateCounterResetButton(),
                GoalSettingsButton(),
                SupplementalCounterButton(),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HelpButton(),
                const ChatLinkButton(),
                PlatformShareButton(),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchableProgressIndicator extends StatefulWidget {
  @override
  _SwitchableProgressIndicatorState createState() =>
      _SwitchableProgressIndicatorState();
}

class _SwitchableProgressIndicatorState
    extends State<SwitchableProgressIndicator> {
  bool isGoal = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isGoal = !isGoal;
        });
      },
      child: isGoal
          ? GoalProgressIndicator()
          : ProhibitedMatterProgressIndicator(),
    );
  }
}

class ProhibitedMatterProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          height: 50,
          child: FutureBuilder(
            future: ProhibitedMatterTimeRepository().monthlySum(DateTime.now()),
            builder: (context, snapshot) => LinearProgressIndicator(
              value: snapshot.data != null
                  ? (snapshot.data as ProhibitedMatterTimeSum).hours / 24
                  : 0,
              backgroundColor: Colors.blueGrey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          ),
        ),
        FutureBuilder(
          future: ProhibitedMatterTimeRepository().monthlySum(DateTime.now()),
          builder: (context, snapshot) => Text(
            (snapshot.data != null
                        ? (snapshot.data as ProhibitedMatterTimeSum).hours
                        : 0) <
                    24
                // ignore: lines_longer_than_80_chars
                ? '今月は${snapshot.data != null ? (snapshot.data as ProhibitedMatterTimeSum).hours : 0}時間無駄にしています'
                : '1日以上の時間を無駄にしています',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
