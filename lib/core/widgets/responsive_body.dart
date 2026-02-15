import 'package:flutter/material.dart';

import 'package:portfolio/utils/responsive.dart';

class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.maxContentWidth),
        child: child,
      ),
    );
  }
}
