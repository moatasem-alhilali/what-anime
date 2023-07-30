import 'package:anime_finder/core/resources/assets_fonts.dart';
import 'package:anime_finder/core/utils/constant.dart';
import 'package:flutter/material.dart';

enum ToolAppThemeType { light, dark }

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  //[Button Background,TabBarTheme]
  canvasColor: const Color(0xff35383F),

  scaffoldBackgroundColor: const Color(0xff181A20),
  //[Container,item]
  primaryColor: const Color(0xff35383F),
  //[Form,Dialog,bottom sheet] && container color default
  splashColor: const Color(0xff1F222A),

  //default color of text
  primaryColorLight: Colors.white,
  fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,

  //dividerTheme
  dividerColor: Colors.grey.withOpacity(0.4),
  dividerTheme: const DividerThemeData(
    thickness: 0.5,
  ),
  //AppBarTheme
  appBarTheme: AppBarTheme(
    foregroundColor: Color(0xff181A20),
    surfaceTintColor: Color(0xff181A20),
    shadowColor: Color(0xff181A20),
    color: Color(0xff181A20),
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xffffffff), size: 24),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,
      fontSize: 22,
    ),
  ),

  //iconTheme
  iconTheme: const IconThemeData(
    color: Color(0xffC8C9CA),
    size: 35,
  ),

  //bottom AppBar Theme
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xff464c52),
    elevation: 2,
  ),
  //tab Bar Theme
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Colors.grey,
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Colors.white,
    indicatorColor: Colors.white,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: Colors.white,
        width: 4.0,
      ),
    ),
  ),
  //icon Button Theme
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      iconSize: 35,
    ),
  ),

  //Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    iconColor: const Color(0xff393939),
    fillColor: const Color(0xff1F222A),
    helperStyle: TextStyle(color: Colors.grey),
    hintStyle: TextStyle(
      fontSize: 18,
      color: Colors.white.withOpacity(.5),
      fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,
      fontWeight: FontWeight.w400,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Color(0xff212428),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xff818285),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
  ),
  //text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        color: Color(0xff5265FF),
        fontSize: 16,
      ),
    ),
  ),
  //elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      alignment: Alignment.center,
      backgroundColor: const Color(0xff393939),
      padding: const EdgeInsets.all(8),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),

  //

  //bottom Sheet Theme
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xff1F222A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
  ),
  //dialog Theme
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xff1F222A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  //BottomNavigationBarThemeData
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.white,
    backgroundColor: Color(0xff1F222A),
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(
      color: Colors.white,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
  ),

  //

  //textTheme
  textTheme: TextTheme(
    //display
    displaySmall: TextStyle(
      color: Colors.white,
      fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,
      fontSize: 18,
    ),

    //headline
    headlineSmall: TextStyle(
      color: Colors.white,
      fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,
      fontSize: 16,
    ),

    //title
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontFamily: isArabic ? AssetsArFonts.regular : AssetsEnFonts.regular,
    ),
  ),
);

//Get Display

TextStyle getDisplayStyle(context) {
  return Theme.of(context).textTheme.displaySmall!;
}

//Get Headline
TextStyle getHeadlineStyle(context) {
  return Theme.of(context).textTheme.headlineSmall!;
}

//Get Title
TextStyle getTitleSmallTheme(context) {
  return Theme.of(context).textTheme.titleSmall!;
}

TextStyle getTitleMediumTheme(context) {
  return Theme.of(context).textTheme.titleMedium!;
}

TextStyle getTitleLargeTheme(context) {
  return Theme.of(context).textTheme.titleLarge!;
}

class DarkColors {
  //[background]
  static const Color background = Color(0xff181A20);
  //[Form,Dialog,bottom sheet]
  static const Color main = Color(0xff1F222A);
  //[Container,item]
  static const Color secondMain = Color(0xff35383F);

  //[button,back-icon,]
  static const Color button = Color(0xff393939);
}
