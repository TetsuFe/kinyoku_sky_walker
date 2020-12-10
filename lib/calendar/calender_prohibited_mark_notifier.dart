import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/calendar/calendar_usecase.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';
import 'package:state_notifier/state_notifier.dart';

final calenderProhibitedMarkDaysNotifierProvider =
    StateNotifierProvider((_) => CalenderProhibitedMarkDaysNotifier());

class CalenderProhibitedMarkDaysNotifier extends StateNotifier<List<DateTime>>
    with LocatorMixin {
  CalenderProhibitedMarkDaysNotifier() : super([]);

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() async {
    state = await CalenderUseCase(repository: ProhibitedMatterTimeRepository())
        .getAllProhibitedMatterDays();
  }

  @override
  set state(List<DateTime> value) {
    super.state = value;
  }
}
