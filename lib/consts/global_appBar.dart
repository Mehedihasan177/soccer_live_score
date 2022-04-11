import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../packages/date_picker_timeline/extra/color.dart';
// import '../constants/constant.dart';
import 'package:hexcolor/hexcolor.dart';

import 'app_colors.dart';

myAppBar(String Name, actions, bottom) {
  return AppBar(

    elevation: 0,
    backgroundColor: AppColors.blue1,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.blue1,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
    title: Center(
        child: Text(
      Name,
      style: TextStyle(
        fontFamily: GoogleFonts.carterOne().fontFamily,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24,
      ),
    ),
    ),
    centerTitle: true,
    actions: actions,
    bottom: PreferredSize(
      preferredSize: new Size(30.0, 50.0),
      child: Container(
        height: 50,
        child: TabBar(
            indicatorPadding: EdgeInsets.zero,
            isScrollable: true, // Required
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: bottom),
      ),
    ),
  );
}

class GlobalPadding {
  static final containerPadding = EdgeInsets.only(top: 10, right: 8, left: 8);
}

GlobalText(text){
 return Text(text, style: TextStyle(fontSize: 12));
}
