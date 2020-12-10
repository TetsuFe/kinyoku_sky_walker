import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/bottom_navigation_scaffold.dart';
import 'package:kinyoku_continue/calendar/calendar_page.dart';
import 'package:kinyoku_continue/data_view/data_page.dart';
import 'package:kinyoku_continue/goal_memo_title_tab_page.dart';
import 'package:kinyoku_continue/history_tab_page.dart';
import 'package:kinyoku_continue/title/stoic_days_count_rule.dart';
import 'package:kinyoku_continue/title/title_repository.dart';
import 'package:kinyoku_continue/title/usecases/get_title_usecase.dart';
import 'package:kinyoku_continue/title/usecases/title_usecase.dart';

import 'home_page.dart';

// ignore: must_be_immutable
class RootPage extends StatelessWidget {
  bool addListeneredFlag = false;
  @override
  Widget build(BuildContext context) {
    return Consumer((ref, read) {
      final getTitleUseCase = GetTitleUseCase.instance;
      final titleUseCase = read(titleUseCaseProvider);
      // 保存
      // 新しい称号に対して最新のものをダイアログに出す
      final rule = StoicDaysCountRule().getCurrentRule();
      TitleRepository titleRepository;
      if (rule == StoicDaysCountRuleType.accumulated) {
        titleRepository = AccumulatedCountTitleRepository();
      } else {
        titleRepository = CurrentCountTitleRepository();
      }
      if (!addListeneredFlag) {
        addListeneredFlag = true;
        titleUseCase.getTitleNotifier().addListener(() {
          final title = titleUseCase.getTitleNotifier().value;
          if (title != null) {
            if (title.name != titleRepository.read()) {
              titleRepository.save(title.name);
              if (titleRepository.read() != null) {
                getTitleUseCase.openShareConfirmDialog(
                    context, title.name, title.stoicDays);
              }
            }
          }
        });
      }
      return BottomNavigationScaffold(
        pages: [
          const HomePage(),
          HistoryTabPage(),
          CalendarPage(),
          const GoalMemoTitleTabPage(),
          DataPage(),
        ],
        navigationBarItems: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '履歴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'カレンダー',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: '目標と称号',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'データ',
          ),
        ],
        appBarTitles: const [
          Text('ホーム'),
          Text('履歴'),
          Text('カレンダー'),
          Text('目標と称号'),
          Text('データ'),
        ],
      );
    });
  }
}
