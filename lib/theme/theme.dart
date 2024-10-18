import 'package:flutter/material.dart';
import 'package:flutter_app_/theme/widget_themes/text_theme.dart';


class AppTheme {
  
static ThemeData lightTheme=ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  textTheme: TTextTheme.lightTextTheme,
  
  

);
static ThemeData darkTheme=ThemeData(
   useMaterial3: true,
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  textTheme: TTextTheme.darkTextTheme,
);
}
