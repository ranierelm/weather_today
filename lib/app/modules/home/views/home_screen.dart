import 'package:flutter/material.dart';
import 'package:weather_today/app/shared/components/footer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Container(
      width: 493,
      height: 1031,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_sky.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Opacity(
        opacity: .9,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF352163), Color(0xFF331972), Color(0xFF33143C)],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: PageView(
              controller: _pageCtrl,
              children: const [
                Center(child: Text('Home')),
                Center(child: Text('search')),
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
        ),
      ),
    );
  }
}
