import 'package:flutter/material.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget child;
  const BackgroundScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

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
                colors: [
                  Color(0xFF352163),
                  Color(0xFF331972),
                  Color(0xFF33143C),
                ],
              ),
            ),
            child: child),
      ),
    );
  }
}
