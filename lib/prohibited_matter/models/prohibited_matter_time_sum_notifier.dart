import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';

class ProhibitedMatterTimeSumNotifier with ChangeNotifier {
  ProhibitedMatterTimeSumNotifier(this.repository)
      : assert(repository != null) {
    reload();
  }

  final ProhibitedMatterTimeRepository repository;
  ProhibitedMatterTimeSum prohibitedMatterTimeSum;

  Future<void> reload() async {
    prohibitedMatterTimeSum = await repository.sum();
    print(prohibitedMatterTimeSum.hours);
    notifyListeners();
  }

  void add(ProhibitedMatterTime prohibitedMatterTime) async {
    await repository.create(prohibitedMatterTime);
    reload();
    notifyListeners();
  }
}

final ChangeNotifierProvider<ProhibitedMatterTimeSumNotifier>
    prohibitedMatterTimeSumNotifierProvider = ChangeNotifierProvider((ref) =>
        ProhibitedMatterTimeSumNotifier(ProhibitedMatterTimeRepository()));
