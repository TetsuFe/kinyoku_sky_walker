import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';
import 'package:kinyoku_continue/title/models/title.dart';
import 'package:kinyoku_continue/title/stoic_days_count_rule.dart';
import 'package:kinyoku_continue/title/title_notifier.dart';
import 'package:meta/meta.dart';

import '../models/title_service.dart';

class TitleUseCase {
  TitleUseCase(
      {@required TitleNotifier titleNotifier,
      @required ProhibitedMatterTimeRepository prohibitedMatterTimeRepository})
      : _titleNotifier = titleNotifier,
        _prohibitedMatterTimeRepository = prohibitedMatterTimeRepository {
    initTitle();
  }
  final TitleNotifier _titleNotifier;
  final ProhibitedMatterTimeRepository _prohibitedMatterTimeRepository;

  final stoicDyasCountRule = StoicDaysCountRule();

  /// 禁欲成功日数 = 初回リセット（利用開始時）から現在時刻までの日数 - リセットした日数
  /// を計算し、称号titleを更新する
  void updateTitle() async {
    final firstResetData =
        await _prohibitedMatterTimeRepository.getFirstResetData();
    if (firstResetData == null) {
      String title;
      if (stoicDyasCountRule.getCurrentRule() ==
          StoicDaysCountRuleType.accumulated) {
        title = TitleService.stoicDaysToTitle(0);
      } else {
        title = TitleService.currentStoicDaysToTitle(0);
      }
      _titleNotifier.value = KinyokuTitle(name: title, stoicDays: 0);
      return;
    }
    final allProhibitedMatters = await _prohibitedMatterTimeRepository.getAll();
    final stoicDays = stoicDyasCountRule.culcurateStoicDays(
        allProhibitedMatters, firstResetData);
    String title;
    if (stoicDyasCountRule.getCurrentRule() ==
        StoicDaysCountRuleType.accumulated) {
      title = TitleService.stoicDaysToTitle(stoicDays);
    } else {
      title = TitleService.currentStoicDaysToTitle(stoicDays);
    }
    _titleNotifier.value = KinyokuTitle(name: title, stoicDays: stoicDays);
  }

  TitleNotifier getTitleNotifier() => _titleNotifier;

  void initTitle() {
    updateTitle();
  }
}

final titleUseCaseProvider = Provider((ref) => TitleUseCase(
    titleNotifier: ref.read(titleNotifierProvider),
    prohibitedMatterTimeRepository:
        ref.read(prohibitedMatterTimeRepositoryProvider)));
