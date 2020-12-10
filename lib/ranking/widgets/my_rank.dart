import 'package:flutter/material.dart';
import 'package:kinyoku_continue/ranking/widgets/ranking_sub_info_view.dart';

import '../models/rank.dart';

class MyRank extends StatelessWidget {
  const MyRank({@required this.future});
  final Future future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Text(
                'あなたはまだランキングデータに登録されていません。明日の午前の更新までお待ちください。あるいは、エラーが発生しています。');
          } else {
            final rank = snapshot.data as Rank;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${rank.rank}',
                              style: const TextStyle(
                                fontSize: 48,
                              )),
                          const TextSpan(
                              text: ' 位', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${rank.maxStoicTime}',
                              style: const TextStyle(
                                fontSize: 48,
                              )),
                          const TextSpan(
                              text: ' 日', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RankingSubInfoView(
                    topXPercent: rank.topXPercent,
                  ),
                ),
              ],
            );
          }
        });
  }
}
