import 'package:flutter/material.dart';
import 'package:kinyoku_continue/goal_memo/goal_page.dart';
import 'package:kinyoku_continue/title/widgets/title_page.dart';

class GoalMemoTitleTabPage extends StatelessWidget {
  const GoalMemoTitleTabPage();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                    text: '目標',
                  ),
                  Tab(
                    text: '称号',
                  ),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            GoalMemoPage(),
            TitlePage(),
          ],
        ),
      ),
    );
  }
}
