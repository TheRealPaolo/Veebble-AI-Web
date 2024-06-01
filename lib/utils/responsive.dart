import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? mobile;
  final Widget? desktop;
//  final Widget tap;

  const ResponsiveWidget({Key? key, this.mobile, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 340 || constraints.maxWidth < 930) {
        return mobile!;
      } else {
        return desktop!;
      }
    });
  }
}
