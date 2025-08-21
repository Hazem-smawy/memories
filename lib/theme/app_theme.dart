import 'package:flutter/material.dart';
import 'package:memories/theme/button_theme.dart';
import 'package:memories/theme/input_decoration_theme.dart';
import 'package:memories/ui/constants.dart';

import 'checkbox_themedata.dart';
import 'theme_data.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: "Noto",
      scaffoldBackgroundColor: Color(0xffffffff),
      iconTheme: IconThemeData(color: blackColor),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: blackColor40)),
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: lightInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: blackColor40),
      ),
      appBarTheme: appBarLightTheme.copyWith(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableLightThemeData,
      dividerTheme: const DividerThemeData(thickness: 0.5),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: "Noto",
      scaffoldBackgroundColor: colorScheme.surface,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white70)),
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: darkInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: Colors.white70),
      ),
      appBarTheme: appBarDarkTheme.copyWith(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableDarkThemeData,
      dividerTheme: const DividerThemeData(thickness: 0.5),
    );
  }
}
