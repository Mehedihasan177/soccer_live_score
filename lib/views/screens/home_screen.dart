import 'package:big_soccer/controllers/setting_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../services/custom_ad/custom_ad.dart';
import '/consts/consts.dart';
import '/controllers/home_controller.dart';
import '/models/match_schedule.dart';
import '/packages/date_picker_timeline/date_picker_timeline.dart';
import 'match_details_screen.dart';
import 'match_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatePickerController _controller = DatePickerController();
  HomeController homeController = Get.put(HomeController());
SettingController settingController = Get.find();
  @override
  void initState() {
    //homeController.isLoading.value;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.animateToDate(DateTime.now().subtract(Duration(days: 2)));
    });
  }

  onClick(String? v) {
    homeController.type.value = v ?? 'ALL';
    homeController.isLoading.value = true;
    homeController.loadLeagues();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      body: Container(
        color: HexColor("f8f8ff"),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(4),
                color: AppColors.text.withOpacity(0.3),
              ),
              child: DatePicker(
                DateTime.now().subtract(const Duration(days: 10)),
                locale: settingController.currentLanguage.value == 'English' ? "en_US" : "vi_VI",
                width: AppSizes.newSize(7),
                height: AppSizes.newSize(6.5),
                controller: _controller,
                dateTextStyle: TextStyle(
                  fontSize: AppSizes.size14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                monthTextStyle: TextStyle(
                  fontSize: AppSizes.size14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.text,
                ),
                dayTextStyle: TextStyle(
                  fontSize: AppSizes.size13,
                  fontWeight: FontWeight.normal,
                  color: AppColors.text,
                ),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.selected,
                selectedTextColor: Colors.grey,
                daysCount: 20,
                onDateChange: (date) {
                  homeController.selectedValue.value = date;
                  homeController.type.value = 'ALL';
                  homeController.isLoading.value = true;
                  homeController.loadLeagues();
                },
              ),
            ),
            Obx(() {
              return (DateFormat('yyyyMMdd')
                  .format(homeController.selectedValue.value) ==
                  DateFormat('yyyyMMdd').format(DateTime.now()))
                  ? Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        onClick('ALL');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Obx(() {
                                return Radio(
                                  value: 'ALL',
                                  groupValue: homeController.type.value,
                                  onChanged: onClick,
                                  activeColor: Colors.black,
                                  fillColor:  MaterialStateColor.resolveWith((states) => Colors.black),
                                );
                              }),
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                'ALL'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: AppSizes.size13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onClick('LIVE');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Obx(() {
                                return Radio(
                                  value: 'LIVE',
                                  groupValue: homeController.type.value,
                                  onChanged: onClick,
                                  activeColor: Colors.black,
                                  fillColor:  MaterialStateColor.resolveWith((states) => Colors.black),
                                );
                              }),
                            ),
                            SizedBox(width: 5),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                'On Going'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: AppSizes.size13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onClick('FT');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Obx(() {
                              return Radio(
                                value: 'FT',
                                groupValue: homeController.type.value,
                                onChanged: onClick,
                                activeColor: Colors.black,
                                fillColor:  MaterialStateColor.resolveWith((states) => Colors.black),
                              );
                            }),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Completed'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.text,
                                fontSize: AppSizes.size13,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  : const SizedBox();
            }),
            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  onRefresh: () => homeController.loadLeagues(),
                  child: !homeController.isLoading.value
                      ? homeController.schedule.isNotEmpty
                      ? ListView.builder(
                      itemCount: homeController.schedule.length,
                      itemBuilder: (context, index) {
                        RexFix fixItem = homeController.schedule[index];
                        print(fixItem.matches);
                        return matchWidget(fixItem, context);
                        // if ((fixItem.matches?.length ?? 0) > 0) {
                        //   return matchWidget(fixItem, context);
                        // } else {
                        //   return Container(
                        //     child: Center(
                        //       child: Text(
                        //         "No Matches",
                        //         style: TextStyle(color: Colors.black),
                        //       ),
                        //     ),
                        //   );
                        // }
                      })
                      : Center(
                    child: Text(
                      'No Matches',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        fontSize: AppSizes.size15,
                      ),
                    ),
                  )
                      : Center(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(AppAssets.loading),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget matchWidget(RexFix fixItem, BuildContext context) {
    return Card(
      elevation: 0.8,
      color: AppColors.background2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      child: ListTileTheme(
        dense: true,
        iconColor: AppColors.text,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: AppColors.text,
            //collapsedIconColor: AppColorss.text,
            //collapsedBackgroundColor: AppColorss.screenBg,
            initiallyExpanded: true,
            title: Text(
              fixItem.title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.text,
                fontSize: AppSizes.size15,
              ),
            ),
            children: [
              Container(
                height: 0.2,
                color: AppColors.border,
              ),
              ...fixItem.matches!.map(
                    (matchItem) => InkWell(
                  onTap: () {
                    var arguments = {
                      'matchId': matchItem.matchId,
                      'result': matchItem.result != ''
                          ? matchItem.result
                          : matchItem.mtime,
                      'score': matchItem.score,
                      'homeName': matchItem.tName1,
                      'homeImage': matchItem.image1,
                      'awayName': matchItem.tName2,
                      'awayImage': matchItem.image2,
                    };

                    CustomInterstitialAd.show(callback: () {
                      if (matchItem.mtime != '') {
                        Get.to(() => MatchPreviewScreen(arguments));
                      } else {
                        if (matchItem.result == 'Postponed' ||
                            matchItem.result == 'TBD') {
                          Get.to(() => MatchPreviewScreen(arguments));
                        } else {
                          Get.to(() => MatchDetailsScreen(arguments));
                        }
                      }
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            //        mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  matchItem.tName1 ?? '',
                                  style: TextStyle(
                                    fontSize: AppSizes.size14,
                                    color: AppColors.text,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: AppSizes.newSize(3.5),
                                height: AppSizes.newSize(3.5),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius:
                                      1, // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: matchItem.image1 ?? '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        width: AppSizes.newSize(3.5),
                                        height: AppSizes.newSize(3.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                  placeholder: (context, url) => Container(
                                    width: AppSizes.newSize(2.5),
                                    padding: const EdgeInsets.all(3),
                                    height: AppSizes.newSize(2.5),
                                    child: Image.asset(AppAssets.loading),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(AppAssets.team),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: matchItem.result == "LIVE" ||
                              matchItem.result == "Postponed" ||
                              matchItem.result == "TBD"
                              ? Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        4, 3, 4, 3),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(4)),
                                    child: Text(
                                      matchItem.result ?? '',
                                      style: TextStyle(
                                        fontSize: AppSizes.size12,
                                        color: matchItem.result != 'LIVE'
                                            ? Colors.white
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                              // if (matchItem.result == "LIVE")
                              //   Text(
                              //     matchItem.score ?? '',
                              //     style: TextStyle(
                              //       fontWeight: FontWeight.normal,
                              //       fontSize: AppSizes.size13,
                              //       color:
                              //           AppColors.text.withOpacity(0.7),
                              //     ),
                              //   )
                            ],
                          )
                              : Container(
                            alignment: Alignment.center,
                            child: matchItem.mtime == "" &&
                                matchItem.score != 'v'
                                ? Column(
                              children: [
                                Text(
                                  matchItem.score ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.size14,
                                    color: AppColors.text,
                                  ),
                                ),
                                Text(
                                  matchItem.result ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppSizes.size13,
                                    color: AppColors.text
                                        .withOpacity(0.7),
                                  ),
                                )
                              ],
                            )
                                : Column(
                              children: [
                                Text(
                                  DateFormat('h:mm a').format(
                                    DateTime
                                        .fromMillisecondsSinceEpoch(
                                      int.parse(matchItem.mtime ??
                                          '') *
                                          1000,
                                    ),
                                  ),
                                  // /item.mtime,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.size13,
                                    color: AppColors.text
                                        .withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMMM').format(
                                    DateTime
                                        .fromMillisecondsSinceEpoch(
                                      int.parse(matchItem.mtime ??
                                          '') *
                                          1000,
                                    ),
                                  ),
                                  // /item.mtime,
                                  style: TextStyle(
                                    fontSize: AppSizes.size12,
                                    color: AppColors.text,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  matchItem.tName2 ?? '',
                                  style: TextStyle(
                                    fontSize: AppSizes.size14,
                                    color: AppColors.text,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: AppSizes.newSize(3.5),
                                height: AppSizes.newSize(3.5),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius:
                                      1, // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: matchItem.image2 ?? '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        width: AppSizes.newSize(3.5),
                                        height: AppSizes.newSize(3.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),
                                  placeholder: (context, url) => Container(
                                    width: AppSizes.newSize(2.5),
                                    padding: const EdgeInsets.all(3),
                                    height: AppSizes.newSize(2.4),
                                    child: Image.asset(AppAssets.loading),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(AppAssets.team),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
