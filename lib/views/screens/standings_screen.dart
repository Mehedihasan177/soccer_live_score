import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import '/consts/consts.dart';
import '/controllers/setting_controller.dart';
import '/controllers/standing_controller.dart';

class StandingsScreen extends StatefulWidget {
  final Map arguments;
  const StandingsScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _StandingsScreenState createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  StandingController standingController = Get.find<StandingController>();
  SettingController settingsController = Get.find<SettingController>();
  int rank = 0;

  @override
  void initState() {
    super.initState();
    standingController.loadStandingYears(widget.arguments['link']);
  }

  @override
  void dispose() {
    super.dispose();

    standingController.isLoading2.value = true;
    standingController.isLoading3.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: AppStyles.appbarOverlay(),
        leading: BackButton(color: Colors.black),
        backgroundColor: AppColors.blue,
        title: widget.arguments['title'].length > 25
            ? Container(
                height: 28,
                // color: Colors.red,
                child: Marquee(
                  text: widget.arguments['title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              )
            : Text(
                widget.arguments['title'],
                style: TextStyle(color: Colors.black),
              ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.blue,
      body: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: !standingController.isLoading2.value
              ? Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 6,
                      ),
                      height: AppSizes.newSize(7.4),
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        color: AppColors.background2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select a session',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.size16,
                                  color: AppColors.text,
                                ),
                              ),
                              Container(
                                height: AppSizes.newSize(7),
                                width: 140,
                                alignment: Alignment.centerRight,
                                child: DropdownSearch<String>(
                                  dropdownButtonBuilder: (context) =>
                                      const Icon(
                                    Icons.expand_more,
                                    color: AppColors.text,
                                  ),
                                  dropdownBuilder: (context, v) {
                                    return Text(
                                      v ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.size16,
                                        color: AppColors.text,
                                      ),
                                    );
                                  },
                                  dropdownSearchDecoration:
                                      const InputDecoration(
                                    isDense: true,
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(0),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  mode: Mode.MENU,
                                  items: standingController.years,
                                  onChanged: (v) {
                                    if (standingController
                                        .standingYears.value.year!.isNotEmpty) {
                                      var y = standingController
                                          .standingYears.value.year!
                                          .where((i) => i.year == v)
                                          .first;

                                      if (y.year!.isNotEmpty) {
                                        standingController.dropdownValue.value =
                                            v!;
                                        setState(() {
                                          standingController
                                              .selectedLink.value = y.link!;
                                          standingController.isLoading3.value =
                                              true;
                                        });
                                        standingController.loadStandings();
                                      }
                                    }
                                  },
                                  selectedItem:
                                      standingController.dropdownValue.value,
                                  popupSafeArea: const PopupSafeArea(
                                    top: false,
                                  ),
                                  popupShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (standingController.teams
                            .where((v) => v.heding.contains('Group'))
                            .isEmpty &&
                        standingController.teams
                            .where((v) => v.heding.contains('GROUP'))
                            .isEmpty)
                      _buildHeader(),
                    Expanded(
                      child: !standingController.isLoading3.value
                          ? SingleChildScrollView(
                              child: ListView.builder(
                                itemCount: standingController.teams.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  if (standingController.teams[i].heding
                                          .contains('Group') ||
                                      standingController.teams[i].heding
                                          .contains('GROUP')) {
                                    return _buildHeader(
                                        standingController.teams[i].heding);
                                  } else {
                                    rank++;
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 0),
                                      decoration: BoxDecoration(
                                        color: AppColors.background2,
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 0.5,
                                            color: AppColors.border,
                                          ),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(7.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              rank.toString(),
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CachedNetworkImage(
                                                imageUrl: standingController
                                                    .teams[i].logo,
                                                width: 25,
                                                height: 25,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        AppAssets.loading),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  AppAssets.team,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                standingController
                                                    .teams[i].heding,
                                                style: TextStyle(
                                                  color: AppColors.text,
                                                  fontSize: AppSizes.size13,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].gP,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].w,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].d,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].l,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].gF,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].gA,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].gD,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              standingController.points[i].p,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset(AppAssets.loading),
                              ),
                            ),
                    ),
                  ],
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
    );
  }

  Widget _buildHeader([heading = 'Team Name']) {
    rank = 0;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(2),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '#',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: Text(
                heading,
                style:
                    TextStyle(color: Colors.black, fontSize: AppSizes.size13),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'GP',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            child: Text(
              'W',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            child: Text(
              'D',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            child: Text(
              'L',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            child: Text(
              'GF',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            child: Text(
              'GA',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            child: Text(
              'GD',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
          Expanded(
            child: Text(
              'P',
              style: TextStyle(color: Colors.black, fontSize: AppSizes.size13),
            ),
          ),
        ],
      ),
    );
  }
}
