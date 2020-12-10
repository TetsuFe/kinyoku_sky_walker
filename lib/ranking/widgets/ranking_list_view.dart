import 'package:flutter/material.dart';
import 'package:kinyoku_continue/auth/user.dart';
import 'package:kinyoku_continue/ranking/models/rank.dart';
import 'package:kinyoku_continue/ranking/ranking_repository.dart';

class RankingFutureListView extends StatelessWidget {
  const RankingFutureListView({@required this.repository, @required this.user});
  final RankingRepository repository;
  final KinyokuUser user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Rank>(
      future: repository.getMyRank(user.getId()),
      builder: (context, myRankSnapshot) {
        if (myRankSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!myRankSnapshot.hasData) {
          return const Text(
              'あなたはまだランキングデータに登録されていません。明日の午前の更新までお待ちください。あるいは、エラーが発生しています。');
        } else {
          return FutureBuilder<List<Rank>>(
              future: repository.getMyLowerAndUpper(user.getId()),
              builder: (context, rankingListSnapshot) {
                if (!rankingListSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return RankingListView(
                      rankingList: rankingListSnapshot.data,
                      myRank: (myRankSnapshot.data).rank);
                }
              });
        }
      },
    );
  }
}

class RankingListView extends StatelessWidget {
  const RankingListView({@required this.rankingList, @required this.myRank});

  final List<Rank> rankingList;
  final int myRank;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: rankingList.length,
        itemBuilder: (context, index) {
          return RankingListCard(
            rank: rankingList[index].rank,
            name: rankingList[index].userId,
            dayRecord: rankingList[index].maxStoicTime,
            backgroundColor: myRank == rankingList[index].rank
                ? Theme.of(context).primaryColor
                : Colors.grey,
          );
        });
  }
}

class RankingListCard extends StatelessWidget {
  const RankingListCard(
      {@required this.rank,
      @required this.name,
      @required this.dayRecord,
      @required this.backgroundColor});

  final int rank;
  final String name;
  final int dayRecord;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 54,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '$rank位',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${name.substring(0, 7)}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    '$dayRecord日',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
