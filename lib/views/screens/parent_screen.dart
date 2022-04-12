import 'package:big_soccer/views/screens/live_match_screen.dart';
import 'package:big_soccer/views/screens/more_screen.dart';
import 'package:big_soccer/views/screens/prediction_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
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

class _ParentScreenState extends State<ParentScreen>
    with TickerProviderStateMixin {
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
    print("settingsController.appPublishingControl.value");
    print(settingsController.appPublishingControl.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      initialIndex: 0,
      length: (settingsController.appPublishingControl.value == true) ? 6 : 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: myAppBar("BONG DA LIVE K9", null, [
          Tab(
            iconMargin: EdgeInsets.only(bottom: 2),
            icon: Image.asset(
              'assets/images/home.png',
              height: 18,
              width: 18,
              color: Colors.white,
            ),
            child: GlobalText("Home".tr),
          ),
          if ((settingsController.appPublishingControl.value == true))
            Tab(
              iconMargin: EdgeInsets.only(bottom: 2),
              icon: Image.asset(
                'assets/images/video.png',
                height: 18,
                width: 18,
                color: Colors.white,
              ),
              child: GlobalText("Live".tr),
            ),
          Tab(
            iconMargin: EdgeInsets.only(bottom: 2),
            icon: Image.asset(
              'assets/images/prediction.png',
              height: 18,
              width: 18,
              color: Colors.white,
            ),
            child: GlobalText("Prediction".tr),
          ),
          Tab(
            iconMargin: EdgeInsets.only(bottom: 2),
            icon: Image.asset(
              'assets/images/standings.png',
              height: 18,
              width: 18,
              color: Colors.white,
            ),
            child: GlobalText("Standings".tr),
          ),
          Tab(
            iconMargin: EdgeInsets.only(bottom: 2),
            icon: Image.asset(
              'assets/images/news.png',
              height: 18,
              width: 18,
              color: Colors.white,
            ),
            child: GlobalText("News".tr),
          ),
          Tab(
            iconMargin: EdgeInsets.only(bottom: 2),
            icon: Image.asset(
              'assets/images/more.png',
              height: 18,
              width: 18,
              color: Colors.white,
            ),
            child: GlobalText("More".tr),
          ),
        ]),
        body: Container(
            child: TabBarView(
              children: [
                const HomeScreen(),
                if ((settingsController.appPublishingControl.value == true))
                  LiveMatchScreen(),
                const PredictionScreen(),
                const StandingLeaguesScreen(),
                const NewsScreen(),
                const MoreScreen(),
              ],
            ),
          ),

        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: CustomBannerAd(),
        ),
      ),
    ));
  }
}
