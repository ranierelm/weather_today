import 'package:flutter/material.dart';
import 'package:weather_today/app/modules/home/views/home_screen.dart';
import 'package:weather_today/app/shared/components/background_scaffold.dart';
import 'package:weather_today/app/shared/components/footer_menu.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _pageIndex = 0;

  final PageController _pageCtrl = PageController();

  void _changePage(int index) {
    if (_pageIndex != index) {
      _pageIndex = index;
      _pageCtrl.jumpToPage(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView(
          controller: _pageCtrl,
          children: const [
            HomeScreen(),
            Center(child: Text('account')),
            Center(child: Text('account')),
            Center(child: Text('Notification')),
          ],
        ),
        bottomNavigationBar: FooterMenu(
          selectedIndex: _pageIndex,
          onIndexChanged: _changePage,
          buttons: [
            FooterMenuIcon(
                icon: 'assets/icons/home.svg',
                semanticsLabel: 'Home screen navigation button'),
            FooterMenuIcon(
                icon: 'assets/icons/magnify.svg',
                semanticsLabel: 'Home screen navigation button'),
            FooterMenuIcon(
                icon: 'assets/icons/account.svg',
                semanticsLabel: 'Home screen navigation button'),
            FooterMenuIcon(
                icon: 'assets/icons/bell-outline.svg',
                semanticsLabel: 'Home screen navigation button'),
          ],
        ),
      ),
    );
  }
}
