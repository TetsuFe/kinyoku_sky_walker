import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/auth/auth_facade.dart';
import 'package:kinyoku_continue/auth/user.dart';
import 'package:kinyoku_continue/ranking/ranking_repository.dart';
import 'package:kinyoku_continue/ranking/widgets/my_rank.dart';
import 'package:kinyoku_continue/ranking/widgets/ranking_list_view.dart';
import 'package:kinyoku_continue/ranking/widgets/ranking_supplimental_info_card.dart';

class RankingPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: AuthFacade().signIn(),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final user = userSnapshot.data as KinyokuUser;
              return Consumer((ref, read) {
                final repository = read(rankingRepositoryProvider);
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // 'あなたの順位(全参加者数 100人)',
                        'あなたの順位(id: ${user.getId().substring(0, 7)})',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyRank(future: repository.getMyRank(user.getId())),
                    const SizedBox(
                      height: 32,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '周りとの差',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RankingFutureListView(repository: repository, user: user),
                    const SizedBox(height: 16),
                    RankingSupplimentalInfoView()
                  ],
                );
              });
            }
          },
        ),
      ),
    );
  }
}
