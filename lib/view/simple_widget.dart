import 'package:flutter/cupertino.dart';

class Height extends StatelessWidget {
  Height(this.height);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class Width extends StatelessWidget {
  Width(this.width);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class RoundDecoration extends BoxDecoration {
  RoundDecoration.circular({Color color, double radius = 8})
      : super(color: color, borderRadius: BorderRadius.circular(radius));

  RoundDecoration({Color color, BorderRadius borderRadius})
      : super(color: color, borderRadius: borderRadius);

  RoundDecoration.gradient({List<Color> colors, double radius})
      : super(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(radius),
        );
}
