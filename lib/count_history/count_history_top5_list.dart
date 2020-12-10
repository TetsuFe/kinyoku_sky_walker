import 'package:flutter/material.dart';
import 'package:kinyoku_continue/count_history/count_history.dart';
import 'package:kinyoku_continue/count_history/count_history_list_view.dart';
import 'package:meta/meta.dart';

class CountHistoryTop5List extends StatelessWidget {
  const CountHistoryTop5List({@required this.countHistoryTop5List});
  final List<CountHistory> countHistoryTop5List;
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: countHistoryTop5List
          .map((e) => CountHistoryListTile(
                countHistory: e,
              ))
          .toList(),
    );
  }
}
