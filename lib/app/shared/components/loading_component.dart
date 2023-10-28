import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingComponent extends StatefulWidget {
  const LoadingComponent({super.key});

  @override
  State<LoadingComponent> createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  final lottieWidget =
      Lottie.asset('assets/animations/weather.json', repeat: true);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(dimension: 150, child: lottieWidget);
  }
}
