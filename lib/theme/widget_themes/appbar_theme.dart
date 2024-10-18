import 'package:flutter/material.dart';



class TAppBarTheme{
  TAppBarTheme._();

  static const AppBarTheme lightAppBarTheme = AppBarTheme(
   
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Color(0xFF232323), size: 24.0),
    actionsIconTheme: IconThemeData(color: Color(0xFFFFFFFF), size: 24.0),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
  );
}