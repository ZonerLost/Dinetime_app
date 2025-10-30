import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class R {
  static Size size(BuildContext c) => MediaQuery.of(c).size;
  static double w(BuildContext c, double pct) => size(c).width * pct / 100;
  static double h(BuildContext c, double pct) => size(c).height * pct / 100;
  static double sp(BuildContext c, double pctOfWidth) => w(c, pctOfWidth);
}

extension Buildd on BuildContext{
  Size get size => MediaQuery.sizeOf(this);

  double get screenHeight => size.height;
  double get screenWidth => size.width;
}