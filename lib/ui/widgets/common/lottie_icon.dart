import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieIcon extends StatelessWidget {
  const LottieIcon(
    this.name, {
    super.key,

    this.animate = false,
    this.size = 200,
  });
  final String name;
  final bool animate;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lotties/$name.json',
      animate: animate,
      width: size,
      height: size,
    );
  }
}
