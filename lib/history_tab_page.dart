import 'package:flutter/material.dart';
import 'package:kinyoku_continue/count_history/count_history_page.dart';
import 'package:kinyoku_continue/prohibited_matter/widgets/prohibited_matter_time_history_page.dart';

class HistoryTabPage extends StatelessWidget {
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
                    text: '禁欲',
                  ),
                  Tab(text: '発散'),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CountHistoryPage(),
            ProhibitedMatterTimeHistoryPage(),
          ],
        ),
      ),
    );
  }
}
