import 'package:flutter/material.dart';
import 'app_streamer.dart';
import 'app_bottom_bar.dart';
import 'tab_navigator.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  int badgeCount = 3;
  var _currentTab = TabItem.home;

  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.history: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
    // Use below if needs to pop until root view is needed
    // _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void initState() {
    addBadgeStreamListener();
    listenToSelectedTabStream();
    super.initState();
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          body: _buildBody(),
          bottomNavigationBar: AppBottomNavigationBar(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
            selectedPage: _selectedPage,
            badgeCount: badgeCount,
          )),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _selectedPage,
      children: [
        _buildOffstageNavigator(TabItem.home),
        _buildOffstageNavigator(TabItem.search),
        _buildOffstageNavigator(TabItem.history)
      ],
    );
  }

  listenToSelectedTabStream() {
    AppStreamer.instance.tabSelectedStreamBuilder.stream.listen((tabObject) {
      if (_selectedPage == tabObject.selectedTab) {}
      if (tabObject.selectedTab != -1) {
        if (_selectedPage == 2) {
          getupdatedBadgeCount();
        }
        setState(() {
          _selectedPage = tabObject.selectedTab;
          switch (_selectedPage) {
            case 0:
              _selectTab(TabItem.home);
              break;
            case 1:
              _selectTab(TabItem.search);
              break;
            case 2:
              _selectTab(TabItem.history);
              break;
            default:
          }
        });
      }
    }, onDone: () {}, onError: (error) {});
  }

  addBadgeStreamListener() {
    AppStreamer.instance.streamBuilder.stream.listen((data) {
      if (data > 0) {
        setState(() {
          badgeCount = data;
        });
      }
    }, onDone: () {}, onError: (error) {});
  }

  getupdatedBadgeCount() {
    AppStreamer.instance.streamBuilder.add(++badgeCount);
  }
}
