import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/count_history/count_history_average_notifier.dart';
import 'package:kinyoku_continue/count_history/count_history_list_notifier.dart';
import 'package:kinyoku_continue/count_history/count_history_list_view.dart';
import 'package:kinyoku_continue/count_history/count_history_top5_list.dart';

class CountHistoryPage extends StatefulWidget {
  @override
  _CountHistoryPageState createState() => _CountHistoryPageState();
}

class _CountHistoryPageState extends State<CountHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CountAverageCard(),
            const SizedBox(
              height: 16,
            ),
            CountHistoryCard(),
          ],
        ),
      ),
    );
  }
}

class CountAverageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              '平均継続時間',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 32),
              child: Consumer((context, read) {
                final countHistoryAverage =
                    read(countHistoryAverageNotifierProvider)
                        .countHistoryAverage;
                if (countHistoryAverage == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text(
                    '${countHistoryAverage.days}日'
                    ' ${countHistoryAverage.hours}時間'
                    ' ${countHistoryAverage.minutes}分',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CountHistoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Top 5',
            style: TextStyle(fontSize: 24),
          ),
          Consumer(
            (context, read) {
              final countHistoryTop5List =
                  read(countHistoryTop5ListNotifierProvider)
                      .countHistoryTop5List;
              if (countHistoryTop5List == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CountHistoryTop5List(
                  countHistoryTop5List: countHistoryTop5List,
                );
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            '全履歴',
            style: TextStyle(fontSize: 24),
          ),
          Consumer(
            (context, read) {
              final countHistoryList =
                  read(countHistoryListNotifierProvider).value;
              if (countHistoryList == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CountHistoryListView(
                  countHistoryList: countHistoryList,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
