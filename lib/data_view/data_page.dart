import 'package:flutter/material.dart';
import 'package:kinyoku_continue/ranking/widgets/ranking_page.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RankingPage(),
    );
    /*DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                tabs: <Tab>[
                  Tab(
                    text: 'ランキング',
                  ),
                  Tab(text: 'その他'),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RankingPage(),
            OtherDataPage(),
          ],
        ),
      ),
    );
       */
  }
}
