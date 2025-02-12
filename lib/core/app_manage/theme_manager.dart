import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,

    /// main colors
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: Color(0xFFDDE8EA),

    primaryColorLight: ColorManager.background,
    // primaryColorDark: ColorManager.background,
    // disabledColor: ColorManager.grey1,
    // splashColor: ColorManager.lightPrimary  /*ripple effect color*/,

    /// fontFamily
    fontFamily: FontConstants.fontFamily,

    /// cardView Theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
      /* margin: ,
    shape: RoundedRectangleBorder(
      borderRadius: ,
      side: ,
    ),*/
    ),

    /// app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.white,
        elevation: AppSize.s4,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff528A89),
        ),
        foregroundColor: ColorManager.textGray,
        titleTextStyle: getRegularStyle(
            fontSize: FontSize.s16, color: ColorManager.textGray)),

    /// button theme

    buttonTheme: const ButtonThemeData(
      /// ([RoundedRectangleBorder]), continuous rectangles
      /// ([ContinuousRectangleBorder]), or beveled rectangles
      /// ([BeveledRectangleBorder]).
      shape: RoundedRectangleBorder(),
      // disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      // splashColor: ColorManager.lightPrimary
    ),

    ///

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s4),
        ),
      ),
    ),

    /// textTheme
    textTheme: TextTheme(
      displayLarge:
          getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s19),
      bodyLarge:
          getMediumStyle(color: ColorManager.white, fontSize: FontSize.s25),
      displaySmall:
          getBoldStyle(color: ColorManager.secondary, fontSize: FontSize.s18),
      titleLarge:
          getMediumStyle(color: ColorManager.textGray, fontSize: FontSize.s14),
      // button
      labelLarge:
          getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
      displayMedium:
          getMediumStyle(color: ColorManager.textGray, fontSize: FontSize.s16),
      titleMedium:
          getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s18),
      bodyMedium:
          getBoldStyle(color: ColorManager.textGray, fontSize: FontSize.s14),
      bodySmall:
          getMediumStyle(color: ColorManager.textGray, fontSize: FontSize.s12),
    ),

    /// input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
      fillColor: ColorManager.white,

      // hint style
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle:
          getRegularStyle(color: ColorManager.error, fontSize: FontSize.s14),

      // enabled border style
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.secondary,
          width: AppSize.s1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s4),
        ),
      ),

      // focused border style
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s4),
        ),
      ),

      // error border style
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s4),
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s4),
        ),
      ),
    ),

    // label style
  );
}

void statusBarColor({Color? color}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color ?? ColorManager.primary,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
}
