import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/title/models/current_title_names.dart';
import 'package:kinyoku_continue/title/models/title_names.dart';
import 'package:kinyoku_continue/title/models/title_service.dart';
import 'package:kinyoku_continue/title/stoic_days_count_rule.dart';
import 'package:kinyoku_continue/title/title_notifier.dart';
import 'package:kinyoku_continue/title/usecases/get_stoic_days_usecase.dart';
import 'package:kinyoku_continue/title/usecases/switch_title_usecase.dart';
import 'package:kinyoku_continue/title/usecases/title_usecase.dart';

class TitlePage extends StatelessWidget {
  const TitlePage();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Consumer((context, read) {
            final title = read(titleNotifierProvider).value;
            if (title == null) {
              read(titleUseCaseProvider).updateTitle();
              return const Center(child: CircularProgressIndicator());
            } else {
              final nextTitle = read(titleUseCaseProvider)
                  .getTitleNotifier()
                  .value
                  .nextTitleName();
              return Column(children: [
                const Text(
                  '現在の称号',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  '${title.name}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                Text(
                    '次の称号「$nextTitle」まであと${title.getNextDaysForNextTitle()}日！'),
                const SizedBox(height: 64),
                TitleStoicDaysCountRule(),
                const SizedBox(height: 64),
                GotTitleListSection(),
              ]);
            }
          })),
    );
  }
}

class TitleStoicDaysCountRule extends StatefulWidget {
  @override
  _TitleStoicDaysCountRuleState createState() =>
      _TitleStoicDaysCountRuleState();
}

class _TitleStoicDaysCountRuleState extends State<TitleStoicDaysCountRule> {
  StoicDaysCountRuleType ruleType;

  final switchTitleUseCase = SwitchTitleUseCase();
  final getStoicDaysCountRuleUseCase = GetStoicDaysCountRuleUseCase();

  @override
  void initState() {
    super.initState();
    ruleType = getStoicDaysCountRuleUseCase.getCurrentRule();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '日数の計算方式',
          style: TextStyle(fontSize: 24),
        ),
        Consumer((ref, read) {
          final titleUseCase = read(titleUseCaseProvider);
          return Switch(
            value: ruleType == StoicDaysCountRuleType.current,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.orange,
            onChanged: (value) {
              setState(() {
                if (ruleType == StoicDaysCountRuleType.current) {
                  switchTitleUseCase.switchStoicDaysCountRule(
                      StoicDaysCountRuleType.accumulated);
                  ruleType = StoicDaysCountRuleType.accumulated;
                } else {
                  switchTitleUseCase
                      .switchStoicDaysCountRule(StoicDaysCountRuleType.current);
                  ruleType = StoicDaysCountRuleType.current;
                }
                titleUseCase.updateTitle();
              });
            },
          );
        }),
        ruleType == StoicDaysCountRuleType.current
            ? const Text('連続')
            : const Text('累計'),
      ],
    );
  }
}

class GotTitleListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer((context, read) {
      final currentRule =
          read(titleUseCaseProvider).stoicDyasCountRule.getCurrentRule();
      final gotTitlesLastIndex =
          currentRule == StoicDaysCountRuleType.accumulated
              ? titleNames.indexOf(TitleService.stoicDaysToTitle(
                  read(titleNotifierProvider).value.stoicDays))
              : currentTitleNames.indexOf(TitleService.currentStoicDaysToTitle(
                  read(titleNotifierProvider).value.stoicDays));
      print(gotTitlesLastIndex);
      final gotTitleList = currentRule == StoicDaysCountRuleType.accumulated
          ? titleNames.sublist(0, gotTitlesLastIndex + 1)
          : currentTitleNames.sublist(0, gotTitlesLastIndex + 1);
      return Column(
        children: [
          const Text(
            '獲得した称号',
            style: TextStyle(fontSize: 24),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: gotTitleList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ListTile(
                title: Text(currentRule == StoicDaysCountRuleType.accumulated
                    ? titleNames[index]
                    : currentTitleNames[index]),
                trailing: Text(
                    // ignore: lines_longer_than_80_chars
                    '${currentRule == StoicDaysCountRuleType.accumulated ? titleUnlockDays[index] : currentTitleUnlockDays[index]}日'),
              ),
            ),
          ),
        ],
      );
    });
  }
}
