import 'package:flutter/widgets.dart';

enum ScreenSize { compact, medium, expanded }

extension ResponsiveX on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  ScreenSize get screenSize {
    final width = screenWidth;
    if (width < 600) return ScreenSize.compact;
    if (width < 840) return ScreenSize.medium;
    return ScreenSize.expanded;
  }

  bool get isCompact => screenSize == ScreenSize.compact;
  bool get isMedium => screenSize == ScreenSize.medium;
  bool get isExpanded => screenSize == ScreenSize.expanded;

  double get horizontalPadding => switch (screenSize) {
        ScreenSize.compact => 16,
        ScreenSize.medium => 32,
        ScreenSize.expanded => 48,
      };

  double get maxContentWidth => switch (screenSize) {
        ScreenSize.compact => double.infinity,
        ScreenSize.medium => 720,
        ScreenSize.expanded => 960,
      };
}
