import 'package:flutter/material.dart';

extension TextStyleExtension on BuildContext {
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;

  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;

  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;

  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;

  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;

  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;

  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;

  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
}

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get topPadding => MediaQuery.of(this).viewPadding.top;

  double get bottomPadding => MediaQuery.of(this).viewInsets.bottom;

  double get appBarH => AppBar().preferredSize.height;

  double get heightBody => height - topPadding - bottomPadding - appBarH;

  double get heightBodyWithNav =>
      height - topPadding - bottomPadding - appBarH - 65;
}

extension WidgetModifier on Widget {
  Widget padding([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }
}

extension SizeExtension on num {
  SizedBox get w => SizedBox(width: toDouble());

  SizedBox get h => SizedBox(height: toDouble());
}

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double orZero() {
    if (this == null) {
      return 0.0;
    } else {
      return this!;
    }
  }
}

extension NonNullBool on bool? {
  bool orEmptyB() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}

extension NonNullList<T> on List<T>? {
  List<T> orEmptyList() {
    if (this == null) {
      return [];
    } else {
      return this!;
    }
  }
}
