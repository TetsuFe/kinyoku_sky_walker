import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/prohibited_matter/monthly_carousel_diff_service.dart';
import 'package:kinyoku_continue/prohibited_matter/monthly_carousel_sum_service.dart';
import 'package:kinyoku_continue/prohibited_matter/monthly_carousel_time_service.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_repository.dart';

class ProhibitedMatterTimeMonthlyCarouselNotifier with ChangeNotifier {
  ProhibitedMatterTimeMonthlyCarouselNotifier(this.repository)
      : assert(repository != null) {
    reload();
  }

  int monthIndex = 0;
  final ProhibitedMatterTimeRepository repository;
  List<List<ProhibitedMatterTime>> prohibitedMatterTimeMatrixForCarousel = [[]];
  List<List<List<ProhibitedMatterTime>>> _prohibitedMatterTime3DMatrix = [
    [[]]
  ];
  int get monthLength => _prohibitedMatterTime3DMatrix.length;
  List<List<int>> _weeklyPercentDiffMatrix = [[]];
  List<int> weeklyPercentDiffMonthlyParcial = [];
  List<int> _monthlyTimesList = [];
  int monthlyTimes = 0;

  final _service = MonthlyCarouselTimeService();
  final _sumService = MonthlyCarouselSumService();
  final _diffService = MonthlyCarouselDiffService();

  Future<void> reload() async {
    final allProhibitedMatterTimes = await repository.getAllWithoutFirst();
    _prohibitedMatterTime3DMatrix =
        _service.getWeeklyDividedProhibitedMatterTimes(
            prohibitedMatterTimes: allProhibitedMatterTimes);
    monthIndex = _prohibitedMatterTime3DMatrix.length - 1;
    prohibitedMatterTimeMatrixForCarousel =
        _prohibitedMatterTime3DMatrix[monthIndex];
    _loadWeeklyPercentDiff();
    _loadMonthlyTimesList();
    notifyListeners();
  }

  void _loadWeeklyPercentDiff() {
    _weeklyPercentDiffMatrix =
        _diffService.makeWeeklyPercentDiffMatrix(_prohibitedMatterTime3DMatrix);
    weeklyPercentDiffMonthlyParcial = _weeklyPercentDiffMatrix[monthIndex];
  }

  void _loadMonthlyTimesList() {
    _monthlyTimesList =
        _sumService.makeMonthlyTimesList(_prohibitedMatterTime3DMatrix);
    monthlyTimes = _monthlyTimesList[monthIndex];
  }

  bool goPreviousMonth() {
    if (monthIndex > 0) {
      monthIndex--;
      prohibitedMatterTimeMatrixForCarousel =
          _prohibitedMatterTime3DMatrix[monthIndex];
      weeklyPercentDiffMonthlyParcial = _weeklyPercentDiffMatrix[monthIndex];
      monthlyTimes = _monthlyTimesList[monthIndex];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool goNextMonth() {
    if (monthIndex < _prohibitedMatterTime3DMatrix.length - 1) {
      monthIndex++;
      prohibitedMatterTimeMatrixForCarousel =
          _prohibitedMatterTime3DMatrix[monthIndex];
      weeklyPercentDiffMonthlyParcial = _weeklyPercentDiffMatrix[monthIndex];
      monthlyTimes = _monthlyTimesList[monthIndex];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}

final ChangeNotifierProvider<ProhibitedMatterTimeMonthlyCarouselNotifier>
    prohibitedMatterTimeMonthlyCarouselNotifierProvider =
    ChangeNotifierProvider((ref) => ProhibitedMatterTimeMonthlyCarouselNotifier(
        ProhibitedMatterTimeRepository()));
