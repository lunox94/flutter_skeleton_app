import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryColor = Colors.orange;

class AppTheme {
  static TextTheme get darkTextTheme => _darkTextTheme;

  static TextTheme get lightTextTheme => _lightTextTheme;

  static ThemeData get light => _light;

  static ThemeData get dark => _dark;

  static final TextTheme _lightTextTheme = _buildLightTextTheme();

  static TextTheme _buildLightTextTheme() {
    final defaultTheme =
        GoogleFonts.titilliumWebTextTheme(Typography.blackRedmond);
    return defaultTheme.copyWith(
      bodyText2: defaultTheme.bodyText2!.copyWith(color: Colors.black54),
    );
  }

  static final _darkTextTheme = _buildDarkTextTheme();

  static TextTheme _buildDarkTextTheme() {
    final defaultTheme =
        GoogleFonts.titilliumWebTextTheme(Typography.whiteRedmond);
    return defaultTheme.copyWith(
      bodyText2: defaultTheme.bodyText2!.copyWith(color: Colors.white54),
    );
  }

  static final ThemeData _light = ThemeData(
    primarySwatch: _primaryColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: _primaryColor,
    ),
    buttonTheme: const ButtonThemeData(padding: EdgeInsets.all(8.0)),
    textTheme: _lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white30;
          } else {
            return Colors.white;
          }
        }),
        overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
    ),
  );

  static final ThemeData _dark = ThemeData(
    primarySwatch: _primaryColor,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: Colors.grey[900],
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: _primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: _primaryColor,
    ),
    textTheme: _darkTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white30;
          } else {
            return Colors.white;
          }
        }),
        overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
    ),
  );
}
