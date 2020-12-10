import 'package:flutter/material.dart';
import 'package:kinyoku_continue/count_history/count_history.dart';
import 'package:meta/meta.dart';

class CountHistoryListView extends StatelessWidget {
  const CountHistoryListView({@required this.countHistoryList});
  final List<CountHistory> countHistoryList;
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      reverse: true,
      children: countHistoryList
          .map((e) => CountHistoryListTile(
                countHistory: e,
              ))
          .toList(),
    );
  }
}

class CountHistoryListTile extends StatelessWidget {
  const CountHistoryListTile({@required this.countHistory});
  final CountHistory countHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white),
        ),
      ),
      child: ListTile(
        title: Text(
          '${countHistory.daysWithUnit} '
          '${countHistory.hoursWithUnit} '
          '${countHistory.minutesWithUnit}',
        ),
        trailing: Text(
          countHistory.formattedDate(),
        ),
      ),
    );
  }
}
