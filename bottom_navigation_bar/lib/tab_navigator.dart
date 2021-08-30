// Helper class with common and essential details

import 'package:bottom_navigation_bar/viewcontroller.dart';
import 'package:flutter/material.dart';

enum TabItem { home, search, history }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.search: 'Search',
  TabItem.history: 'History',
};

class TabObject {
  int selectedTab = 0;
  int badgeCount = 0;
  bool isRefreshNeeded = true;
}

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

// 2
class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  // 3
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {String title: ''}) {
    return {
      TabNavigatorRoutes.root: (context) => ViewController(
            title: title,
            onPush: (title) => _push(context, title: title),
          ),
      TabNavigatorRoutes.detail: (context) => ControllerDetailPage(
            title: title,
          ),
    };
  }

  // 4
  @override
  Widget build(BuildContext context) {
    final routeBuilders =
        _routeBuilders(context, title: tabName[this.tabItem]!);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }

  void _push(BuildContext context, {String title: ''}) {
    var routeBuilders = _routeBuilders(context, title: title);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),
    );
  }
}
