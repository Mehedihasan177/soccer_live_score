import 'package:big_soccer/views/screens/live_match_screen.dart';
import 'package:big_soccer/views/screens/more_screen.dart';
import 'package:big_soccer/views/screens/prediction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../consts/global_appBar.dart';
import '../../controllers/setting_controller.dart';
import '../../services/custom_ad/custom_ad.dart';
import '/views/screens/news_screen.dart';
import '/views/screens/home_screen.dart';
import '/consts/consts.dart';
import 'standing_leagues_screen.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({
    Key? key,
    this.page = 0,
  }) : super(key: key);
  final int page;

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  SettingController settingsController = Get.find<SettingController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.page;
    super.initState();

    CustomInterstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: myAppBar("Big Soccer",null, [Tab(icon: Image.asset(
          'assets/images/home.png',
          height: 22,
          width: 22,
          color: Colors.white,
        ), text: "Home"),
          if ((settingsController.appPublishingControl.value))
            Tab(icon: Image.asset(
              'assets/images/video.png',
              height: 22,
              width: 22,
              color: Colors.white,
            ), text: "Live"),
          Tab(icon: Image.asset(
            'assets/images/prediction.png',
            height: 22,
            width: 22,
            color: Colors.white,
          ), text: "Prediction"),
          Tab(icon: Image.asset(
            'assets/images/standings.png',
            height: 22,
            width: 22,
            color: Colors.white,
          ), text: "Standings"),
          Tab(icon: Image.asset(
            'assets/images/news.png',
            height: 22,
            width: 22,
            color: Colors.white,
          ), text: "News"),
          Tab(icon: Image.asset(
            'assets/images/more.png',
            height: 22,
            width: 22,
            color: Colors.white,
          ), text: "More"),]),
        body:  Container(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              const HomeScreen(),
              if ((settingsController.appPublishingControl.value))
                const LiveMatchScreen(),
              const PredictionScreen(),
              const StandingLeaguesScreen(),
              const NewsScreen(),
              const MoreScreen(),
            ],
          ),
        ),
        // bottomNavigationBar: Theme(
        //   data: Theme.of(context).copyWith(
        //     canvasColor: Colors.transparent,
        //   ),
        //   child: Obx(() {
        //     return Container(
        //       color: Color.fromARGB(255, 188, 184, 184),
        //       margin: const EdgeInsets.only(top: 0.2),
        //       child: SalomonBottomBar(
        //         selectedItemColor: Colors.black,
        //         unselectedItemColor: AppColors.primaryColor,
        //         currentIndex: _selectedIndex,
        //         onTap: _onItemTapped,
        //         itemPadding: const EdgeInsets.symmetric(
        //           vertical: 6,
        //           horizontal: 10,
        //         ),
        //         items: <SalomonBottomBarItem>[
        //           SalomonBottomBarItem(
        //             icon: Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: Image.asset(
        //                 'assets/images/home.png',
        //                 height: 22,
        //                 width: 22,
        //                 color: Colors.black,
        //               ),
        //             ),
        //             title: Text(
        //               'Home',
        //               style: TextStyle(fontSize: AppSizes.size12),
        //             ),
        //           ),
        //           if ((settingsController.appPublishingControl.value))
        //             SalomonBottomBarItem(
        //               icon: Padding(
        //                 padding: const EdgeInsets.all(2.0),
        //                 child: Image.asset(
        //                   'assets/images/video.png',
        //                   height: 22,
        //                   width: 22,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //               title: Text(
        //                 'Live',
        //                 style: TextStyle(fontSize: AppSizes.size12),
        //               ),
        //             ),
        //           SalomonBottomBarItem(
        //             icon: Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: Image.asset(
        //                 'assets/images/prediction.png',
        //                 height: 22,
        //                 width: 22,
        //                 color: Colors.black,
        //               ),
        //             ),
        //             title: Text(
        //               'Prediction',
        //               style: TextStyle(fontSize: AppSizes.size12),
        //             ),
        //           ),
        //           SalomonBottomBarItem(
        //             icon: Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: Image.asset(
        //                 'assets/images/standings.png',
        //                 height: 22,
        //                 width: 22,
        //                 color: Colors.black,
        //               ),
        //             ),
        //             title: Text(
        //               'Standings',
        //               style: TextStyle(fontSize: AppSizes.size12),
        //             ),
        //           ),
        //           SalomonBottomBarItem(
        //             icon: Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: Image.asset(
        //                 'assets/images/news.png',
        //                 height: 22,
        //                 width: 22,
        //                 color: Colors.black,
        //               ),
        //             ),
        //             title: Text(
        //               'News',
        //               style: TextStyle(fontSize: AppSizes.size12),
        //             ),
        //           ),
        //           SalomonBottomBarItem(
        //             icon: Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: Image.asset(
        //                 'assets/images/more.png',
        //                 height: 22,
        //                 width: 22,
        //                 color: Colors.black,
        //               ),
        //             ),
        //             title: Text(
        //               'More',
        //               style: TextStyle(fontSize: AppSizes.size12),
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
      ),
    );
  }
}
