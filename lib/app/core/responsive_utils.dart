import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  // Responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  // Responsive margin
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(8.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(16.0);
    } else {
      return const EdgeInsets.all(24.0);
    }
  }

  // Responsive font sizes
  static double getResponsiveFontSize(BuildContext context, {
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // Responsive grid columns
  static int getGridColumns(BuildContext context, {
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // Responsive container width
  static double getContainerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isMobile(context)) {
      return screenWidth * 0.95;
    } else if (isTablet(context)) {
      return screenWidth * 0.85;
    } else {
      return screenWidth * 0.75;
    }
  }

  // Responsive card height
  static double getCardHeight(BuildContext context, {
    double mobile = 200.0,
    double tablet = 250.0,
    double desktop = 300.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // Responsive icon size
  static double getIconSize(BuildContext context, {
    double mobile = 24.0,
    double tablet = 28.0,
    double desktop = 32.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // Responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    if (isMobile(context)) {
      return kToolbarHeight;
    } else {
      return kToolbarHeight + 20;
    }
  }

  // Responsive drawer width
  static double getDrawerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isMobile(context)) {
      return screenWidth * 0.85;
    } else if (isTablet(context)) {
      return 350.0;
    } else {
      return 400.0;
    }
  }

  // Get responsive layout based on screen size
  static Widget getResponsiveLayout({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  // Responsive spacing
  static double getResponsiveSpacing(BuildContext context, {
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // Responsive border radius
  static double getResponsiveBorderRadius(BuildContext context, {
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
}

// Extension for easier access to responsive utilities
extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isSmallScreen => ResponsiveUtils.isSmallScreen(this);
  bool get isLargeScreen => ResponsiveUtils.isLargeScreen(this);
  
  EdgeInsets get responsivePadding => ResponsiveUtils.getResponsivePadding(this);
  EdgeInsets get responsiveMargin => ResponsiveUtils.getResponsiveMargin(this);
  double get containerWidth => ResponsiveUtils.getContainerWidth(this);
  double get appBarHeight => ResponsiveUtils.getAppBarHeight(this);
  double get drawerWidth => ResponsiveUtils.getDrawerWidth(this);
  
  double responsiveFontSize({
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) => ResponsiveUtils.getResponsiveFontSize(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  int gridColumns({
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) => ResponsiveUtils.getGridColumns(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  double cardHeight({
    double mobile = 200.0,
    double tablet = 250.0,
    double desktop = 300.0,
  }) => ResponsiveUtils.getCardHeight(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  double iconSize({
    double mobile = 24.0,
    double tablet = 28.0,
    double desktop = 32.0,
  }) => ResponsiveUtils.getIconSize(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  double spacing({
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) => ResponsiveUtils.getResponsiveSpacing(this, mobile: mobile, tablet: tablet, desktop: desktop);
  
  double borderRadius({
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) => ResponsiveUtils.getResponsiveBorderRadius(this, mobile: mobile, tablet: tablet, desktop: desktop);
}
