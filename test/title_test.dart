// 0日
import 'package:flutter_test/flutter_test.dart';
import 'package:kinyoku_continue/auth/auth_facade.dart';
import 'package:kinyoku_continue/counter/count_start_date_repository.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time_notifier.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';
import 'package:kinyoku_continue/reset/reset_api.dart';
import 'package:kinyoku_continue/this_app_shared_preference.dart';
import 'package:kinyoku_continue/title/models/title_service.dart';
import 'package:kinyoku_continue/title/title_notifier.dart';
import 'package:kinyoku_continue/title/usecases/title_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockElapsedTimeNotifier extends Mock implements ElapsedTimeNotifier {
  MockElapsedTimeNotifier(CountStateDateRepository _) : super();
}

class MockAuthFacade extends Mock implements AuthFacade {}

class MockResetApi extends Mock implements ResetApi {}

class MockProhibitedMatterTimeRepository extends Mock
    implements ProhibitedMatterTimeRepository {}

void main() {
  test('禁欲０日目の称号と次の称号', () async {
    // モック
    // sharedpreferenceに依存しているため、一応使っているが意味はない
    SharedPreferences.setMockInitialValues(
        {'countStartDate': DateTime(2020, 7, 1).toIso8601String()});
    SharedPreferences.setMockInitialValues(
        {'stoicDaysCountRuleType': 'StoicDaysCountRuleType.accumulated'});
    sharedPreference = await SharedPreferences.getInstance();

    final mockElapsedTimeNotifier = MockElapsedTimeNotifier(
        CountStateDateRepository(
            resetApi: MockResetApi(), sharedPreferences: sharedPreference));
    when(mockElapsedTimeNotifier.getElapsedTime())
        .thenReturn(ElapsedTime(const Duration(days: 0)));

    // テスト対象
    final titleNotifier = TitleNotifier();
    TitleUseCase(
            titleNotifier: titleNotifier,
            prohibitedMatterTimeRepository:
                MockProhibitedMatterTimeRepository())
        .initTitle();
    // initTitleを待つ
    await Future.delayed(const Duration(seconds: 1));
    expect(titleNotifier.value.name, '猿');
    expect(titleNotifier.value.nextTitleName(), '猿賢者');
  });

  test('禁欲９日目の称号と次の称号', () async {
    // モック
    // sharedpreferenceに依存しているため、一応使っているが意味はない
    SharedPreferences.setMockInitialValues(
        {'countStartDate': DateTime(2020, 7, 1).toIso8601String()});
    SharedPreferences.setMockInitialValues(
        {'stoicDaysCountRuleType': 'StoicDaysCountRuleType.current'});
    sharedPreference = await SharedPreferences.getInstance();

    final mockElapsedTimeNotifier = MockElapsedTimeNotifier(
        CountStateDateRepository(
            resetApi: MockResetApi(), sharedPreferences: sharedPreference));

    final resetDate = DateTime(2020, 11, 28);
    final mockProhibitedMatterTimeRepository =
        MockProhibitedMatterTimeRepository();
    when(mockProhibitedMatterTimeRepository.getFirstResetData()).thenAnswer(
        (_) => Future.value(
            ProhibitedMatterTime(hours: 1, minutes: 0, date: resetDate)));
    when(mockProhibitedMatterTimeRepository.getAll()).thenAnswer((_) =>
        Future.value(
            [ProhibitedMatterTime(hours: 1, minutes: 0, date: resetDate)]));

    // テスト対象
    final titleNotifier = TitleNotifier();
    TitleUseCase(
            titleNotifier: titleNotifier,
            prohibitedMatterTimeRepository: mockProhibitedMatterTimeRepository)
        .initTitle();
    // initTitleを待つ
    await Future.delayed(const Duration(seconds: 1));
    expect(titleNotifier.value.name, '普通猿');
  });

  test('TitleService getDaysForNextTitle', () {
    expect(TitleService.getDaysForNextTitle(0), 1);
    expect(TitleService.getDaysForNextTitle(1), 1);
    expect(TitleService.getDaysForNextTitle(2), 1);
    expect(TitleService.getDaysForNextTitle(3), 3);
    expect(TitleService.getDaysForNextTitle(364), 1);
    expect(TitleService.getDaysForNextTitle(365), 0);
  });
}
// オナ猿
// 半オナ猿人

// 0日
// 時間が経過
// 1日
// 半オナ猿人
// 一般人
