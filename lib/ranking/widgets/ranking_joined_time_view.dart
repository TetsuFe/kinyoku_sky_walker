import 'package:flutter/material.dart';
import 'package:kinyoku_continue/ranking/ranking_auth_api.dart';

class RankingJoinedTimeView extends StatelessWidget {
  final api = RankingAuthApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DateTime>(
        future: api.getMyRankingJoinedTime(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Text('取得エラーです');
          } else {
            final joinedTime = snapshot.data;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ランキング登録日: ${joinedTime.year}年 '
                      '${joinedTime.month}月 '
                      '${joinedTime.day}日'),
                  const Text('*日数の計算はランキング登録日からとなります。'
                      '途中からの参加となった方には申し訳ありませんが、'
                      '来月のランキングまでお待ちください。')
                ]);
          }
        });
  }
}
