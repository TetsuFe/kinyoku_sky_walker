import 'package:flutter/material.dart';
import 'package:kinyoku_continue/ranking/widgets/ranking_joined_time_view.dart';

class RankingSupplimentalInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          RankingJoinedTimeView(),
          const SizedBox(
            height: 16,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '*ランキングの更新は毎朝7時ごろです。\n'
              '*日数は今月の最高連続禁欲日数です。',
            ),
          ),
        ],
      ),
    );
  }
}
