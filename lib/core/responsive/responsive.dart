import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget? desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop help us later

  static bool isMobileS(BuildContext context) =>
      MediaQuery.of(context).size.width < 375;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768 &&
      MediaQuery.of(context).size.width >= 375;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024 &&
      MediaQuery.of(context).size.width >=  768;


  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1024) {
      return desktop ?? Container();
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width < 1024 && size.width >= 768) {
      return tablet;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
