import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme{
  static bool isDarkModenabled=false;
  static Future<void>getThemeValue() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    isDarkModenabled =sharedPreferences.getBool('isDarkMode') ?? false;
  }
}