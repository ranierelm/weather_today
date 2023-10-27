import 'package:flutter/material.dart';
import 'package:weather_today/app/shared/components/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          child: const Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomNavigationBar(),
          ),
        ),
      ),
    );
  }
}
