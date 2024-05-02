import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CSAppTheme{
  CSAppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.black, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Times New Roman',
      ),
    ),
      iconTheme: IconThemeData(
        color: Colors.grey,
      )
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Times New Roman',
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.blue,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: Colors.black
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Times New Roman',
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      labelStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),

  );
}