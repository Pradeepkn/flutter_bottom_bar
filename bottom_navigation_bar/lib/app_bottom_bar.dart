// ignore: must_be_immutable
import 'package:bottom_navigation_bar/utility.dart';
import 'package:flutter/material.dart';
import 'app_streamer.dart';
import 'dart:math' as math;

import 'tab_navigator.dart'; // import this

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar(
      {required this.currentTab,
      required this.onSelectTab,
      required this.selectedPage,
      required this.badgeCount});
  final int selectedPage;
  final int badgeCount;
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab.index,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black.withOpacity(0.4),
        unselectedLabelStyle: appBoldFont(Colors.black.withOpacity(0.4), 10),
        selectedLabelStyle: appBoldFont(Colors.blueGrey, 10),
        showUnselectedLabels: true,
        onTap: (int index) {
          TabObject tabObject = TabObject();
          tabObject.selectedTab = index;
          AppStreamer.instance.tabSelectedStreamBuilder.add(tabObject);
          onSelectTab(
            TabItem.values[index],
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: bottomIcons(currentTab == TabItem.home ? true : false)[0],
            label: tabName[TabItem.home],
          ),
          BottomNavigationBarItem(
            icon: bottomIcons(currentTab == TabItem.search ? true : false)[1],
            label: tabName[TabItem.search],
          ),
          getNavigationItemWithBadgeCount(),
        ]);
  }

  List<Widget> bottomIcons(bool isSelected) {
    return [
      Icon(
        Icons.home,
        color: isSelected ? Colors.blueAccent : Colors.blueGrey,
      ),
      Icon(
        Icons.access_alarm,
        color: isSelected ? Colors.blueAccent : Colors.blueGrey,
      ),
      Icon(
        Icons.history,
        color: isSelected ? Colors.blueAccent : Colors.blueGrey,
      ),
    ];
  }

  getNavigationItemWithBadgeCount() {
    return BottomNavigationBarItem(
      icon: new Stack(
        children: <Widget>[
          Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child:
                  bottomIcons(currentTab == TabItem.history ? true : false)[2]),
          Positioned(
            right: 0,
            child: badgeCount > 0
                ? Container(
                    decoration: new BoxDecoration(
                      color: primaryRed.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: new Center(
                        child: Text(
                      '$badgeCount',
                      style: appRegularFont(Colors.white, 12),
                      textAlign: TextAlign.center,
                    )),
                  )
                : Container(),
          )
        ],
      ),
      label: tabName[TabItem.history],
    );
  }
}
