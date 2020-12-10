import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/ranking/ranking_repository.dart';

class RankingSubInfoView extends StatelessWidget {
  const RankingSubInfoView({@required this.topXPercent});

  final double topXPercent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Consumer(
        (ref, read) => FutureBuilder(
            future: read(rankingRepositoryProvider).fetchJoinRankUserNumber(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '（上位 $topXPercent % 全${snapshot.data}人）',
                          style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
