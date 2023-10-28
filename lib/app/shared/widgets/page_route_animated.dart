import 'package:flutter/material.dart';

class PageRouteAnimated {
  static Route slide({required Widget screen}) {
    return PageRouteBuilder(
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (_, __, ___) => screen,
    );
  }
}
