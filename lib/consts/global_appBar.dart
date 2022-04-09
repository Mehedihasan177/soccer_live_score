import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../packages/date_picker_timeline/extra/color.dart';
// import '../constants/constant.dart';
import 'package:hexcolor/hexcolor.dart';

import 'app_colors.dart';
myAppBar(String Name, actions, bottom) {
  return AppBar(
    // backgroundColor: Colors.red,
    elevation: 0,
    backgroundColor: AppColors.blue,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    title: Center(child: Text(Name, style: TextStyle(
      fontFamily: GoogleFonts.carterOne().fontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 24,
    ),)),
    centerTitle: true,
    leading: const SizedBox(),

    // backgroundColor: mainAppColor,
    actions: actions,
    bottom: TabBar(
        isScrollable: true, // Required
        // unselectedLabelColor: Colors.white30, // Other tabs color
        // labelPadding: EdgeInsets.symmetric(horizontal: 30), // Space between tabs
        // indicator: UnderlineTabIndicator(
        //   // borderSide: BorderSide(color: Colors.white, width: 14,), // Indicator height
        //   // insets: EdgeInsets.symmetric(horizontal: 48), // Indicator width
        // ),
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        tabs: bottom),
  );
}


class GlobalPadding{
  static final containerPadding = EdgeInsets.only(top: 10, right: 8, left: 8);
}
