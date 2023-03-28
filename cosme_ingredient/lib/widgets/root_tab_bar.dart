import 'package:flutter/cupertino.dart';
import 'package:cosme_ingredient/screens/home_screen.dart';
import 'package:cosme_ingredient/screens/add_cosmetic_screen.dart';

// ナビゲーションのルートとして使うために、タブを持つ新しいウィジェットを作成します。
class RootTabBar extends StatefulWidget {
  @override
  _RootTabBarState createState() => _RootTabBarState();
}

class _RootTabBarState extends State<RootTabBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add), label: 'Add'),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return HomeScreen();
              case 1:
                return AddCosmeticScreen();
              default:
                return HomeScreen();
            }
          },
        );
      },
    );
  }
}
