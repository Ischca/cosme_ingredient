import 'package:flutter/cupertino.dart';
import 'package:cosme_ingredient/screens/home_screen.dart';
import 'package:cosme_ingredient/screens/add_cosmetic_screen.dart';

class HomeScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class AddCosmeticScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddCosmeticScreen();
  }
}

// ナビゲーションのルートとして使うために、タブを持つ新しいウィジェットを作成します。
class RootTabBar extends StatelessWidget {
  final List<Widget> _pages = [HomeScreenWrapper(), AddCosmeticScreenWrapper()];
  final Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: 'Add',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          navigatorKey: _navigatorKeys[index],
          builder: (BuildContext context) {
            return _pages[index];
          },
        );
      },
    );
  }
}
