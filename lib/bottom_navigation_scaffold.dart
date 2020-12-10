import 'package:flutter/material.dart';
import 'package:kinyoku_continue/admob/banner_ad_height.dart';
import 'package:kinyoku_continue/rating/rating.dart';

class BottomNavigationScaffold extends StatefulWidget {
  const BottomNavigationScaffold(
      {this.pages, this.navigationBarItems, this.appBarTitles})
      : assert(pages.length == navigationBarItems.length),
        assert(pages.length == appBarTitles.length);

  final List<Widget> pages;
  final List<BottomNavigationBarItem> navigationBarItems;
  final List<Text> appBarTitles;

  @override
  _BottomNavigationScaffoldState createState() =>
      _BottomNavigationScaffoldState();
}

class _BottomNavigationScaffoldState extends State<BottomNavigationScaffold> {
  int _bottomNavigationBarIndex = 0;

  /// なぜか analysisにひっかかるため、ignoreした
  // ignore: unused_field
  Text _appBarTitle;

  @override
  void initState() {
    super.initState();
    _appBarTitle = widget.appBarTitles[0];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        initializeRateMyAppDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const BannerADSpacer(),
              Expanded(
                child: IndexedStack(
                    index: _bottomNavigationBarIndex, children: widget.pages),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[850],
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                changeBottomNavigationIndex(index);
              });
            },
            currentIndex: _bottomNavigationBarIndex,
            items: widget.navigationBarItems));
  }

  void changeBottomNavigationIndex(int index) {
    _bottomNavigationBarIndex = index;
    _appBarTitle = widget.appBarTitles[_bottomNavigationBarIndex];
  }
}

extension IndexedMap<T> on List<T> {
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(index, element));
    });
    return list;
  }
}
