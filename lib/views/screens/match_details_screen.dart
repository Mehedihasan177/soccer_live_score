// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/consts/consts.dart';
import '/controllers/match_details_controller.dart';
import '/controllers/setting_controller.dart';
import '/models/match_commentary.dart';
import '/views/widgets/indicator.dart';
import '/views/widgets/liveup_player_widget.dart';
import '/views/widgets/marquee_widget.dart';
import '/views/widgets/sabt.dart';

class MatchDetailsScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final arguments;
  const MatchDetailsScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _MatchDetailsScreenState createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen>
    with TickerProviderStateMixin {
  MatchDetailsController matchDetailsController =
      Get.find<MatchDetailsController>();
  SettingController settingsController = Get.find<SettingController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? _tabController;
  TabController? _tabController2;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController2 = TabController(length: 3, vsync: this);

    _tabController!.animateTo(1);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      matchDetailsController.loadMatchHeader(widget.arguments['matchId']);
    });
  }

  @override
  void dispose() {
    super.dispose();

    matchDetailsController.cDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background3,
      key: _scaffoldKey,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                systemOverlayStyle: AppStyles.appbarOverlay(),
                leading: BackButton(color: Colors.black),
                backgroundColor: AppColors.primaryColor,
                expandedHeight: AppSizes.newSize(20),
                elevation: 0,
                floating: false,
                pinned: true,
                title: SABT(
                  child: Container(
                    height: 20,
                    child: MarqueeWidget(
                      text: matchDetailsController
                              .matchDetailsHeader.value.data?.league ??
                          '',
                      textStyle: TextStyle(
                        fontSize: AppSizes.size13,
                        color: AppColors.text,
                      ),
                      scrollAxis: Axis.horizontal,
                    ),
                  ),
                ),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    constraints: BoxConstraints(maxHeight: 145),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          // flex: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(top: 60),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: widget.arguments['homeImage'],
                                        height: 40,
                                        width: 40,
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(AppAssets.loading),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        widget.arguments['homeName'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.text,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppSizes.size13,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                // ignore: avoid_unnecessary_containers
                                child: Container(
                                  margin: EdgeInsets.only(top: 60),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (widget.arguments['score'] != 'LIVE')
                                        Text(
                                          widget.arguments['score'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.newSize(5),
                                          ),
                                        ),
                                      if (widget.arguments['score'] == 'LIVE')
                                        Text(
                                          matchDetailsController
                                                  .matchDetailsHeader
                                                  .value
                                                  .data
                                                  ?.gameTime ??
                                              '',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: AppSizes.size16,
                                          ),
                                        ),
                                      if (widget.arguments['score'] == 'LIVE')
                                        SizedBox(height: 10),
                                      if (widget.arguments['score'] == 'LIVE')
                                        Text(
                                          '${matchDetailsController.matchDetailsHeader.value.data?.teamHomeScore ?? ''} - ${matchDetailsController.matchDetailsHeader.value.data?.teamAwayScore ?? ''}',
                                          style: TextStyle(
                                            color: AppColors.text2,
                                            fontSize: AppSizes.size20,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                // child: Container(
                                //   margin: EdgeInsets.only(top: 60),
                                //   child: Obx(() {
                                //     return Column(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         if (widget.arguments['score'] != 'LIVE')
                                //           Text(
                                //             widget.arguments['score'],
                                //             textAlign: TextAlign.center,
                                //             style: TextStyle(
                                //               color: AppColors.text,
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: AppSizes.newSize(5),
                                //             ),
                                //           ),
                                //         if (widget.arguments['score'] == 'LIVE')
                                //           Text(
                                //             matchDetailsController
                                //                     .matchDetailsHeader
                                //                     .value
                                //                     .data
                                //                     ?.gameTime ??
                                //                 '',
                                //             style: TextStyle(
                                //               color: Colors.red,
                                //               fontSize: AppSizes.size16,
                                //             ),
                                //           ),
                                //         if (widget.arguments['score'] == 'LIVE')
                                //           SizedBox(height: 10),
                                //         if (widget.arguments['score'] == 'LIVE')
                                //           Text(
                                //             '${matchDetailsController.matchDetailsHeader.value.data?.teamHomeScore ?? ''} - ${matchDetailsController.matchDetailsHeader.value.data?.teamAwayScore ?? ''}',
                                //             style: TextStyle(
                                //               color: AppColors.text,
                                //               fontSize: AppSizes.size16,
                                //             ),
                                //           ),
                                //       ],
                                //     );
                                //   }),
                                // ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(top: 60),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: widget.arguments['awayImage'],
                                        height: 40,
                                        width: 40,
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(AppAssets.loading),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Flexible(
                                        child: Text(
                                          widget.arguments['awayName'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.text,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.size13,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    onTap: (v) {
                      if (v == 0) {
                        matchDetailsController
                            .loadLineUp(widget.arguments['matchId']);
                      }
                      if (v == 1) {
                        matchDetailsController
                            .loadCommentary(widget.arguments['matchId']);
                      }
                      if (v == 2) {
                        matchDetailsController
                            .loadStatistics(widget.arguments['matchId']);
                      }
                    },
                    controller: _tabController,
                    labelColor: AppColors.text,
                    unselectedLabelColor: AppColors.text,
                    indicatorColor: AppColors.text,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 4.0, color: AppColors.text),
                    ),
                    tabs: const [
                      Tab(text: "Line-Ups"),
                      Tab(text: "Commentary"),
                      Tab(text: "Statistics"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(color: AppColors.background),
            child: Obx(() {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
                  if (!matchDetailsController.isLoading2.value &&
                      matchDetailsController.playerList.isEmpty)
                    Center(
                      child: Text(
                        'No Player List',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    !matchDetailsController.isLoading2.value &&
                            matchDetailsController.playerList.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () {
                              matchDetailsController
                                  .loadMatchHeader(widget.arguments['matchId']);
                              return matchDetailsController
                                  .loadLineUp(widget.arguments['matchId']);
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: 240,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.border,
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () {
                                            _tabController2!.animateTo(0);

                                            setState(() {
                                              matchDetailsController
                                                  .isLoading2In.value = true;
                                              matchDetailsController
                                                  .currentIndex.value = 0;
                                              matchDetailsController
                                                  .teamIndex.value = 0;
                                            });
                                            matchDetailsController.loadLineUp(
                                                widget.arguments['matchId']);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: matchDetailsController
                                                          .currentIndex.value ==
                                                      0
                                                  ? AppColors.background2
                                                  : Colors.transparent,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  widget.arguments['homeImage'],
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  matchDetailsController
                                                          .matchDetailsHeader
                                                          .value
                                                          .data
                                                          ?.homeAwayS ??
                                                      'Team 1',
                                                  style: TextStyle(
                                                    color: AppColors.text,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () {
                                            _tabController2!.animateTo(1);
                                            setState(() {
                                              matchDetailsController
                                                  .isLoading2In.value = true;
                                              matchDetailsController
                                                  .currentIndex.value = 1;
                                              matchDetailsController
                                                  .teamIndex.value = 1;
                                            });
                                            matchDetailsController.loadLineUp(
                                                widget.arguments['matchId']);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: matchDetailsController
                                                          .currentIndex.value ==
                                                      1
                                                  ? AppColors.background2
                                                  : Colors.transparent,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  widget.arguments['awayImage'],
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  matchDetailsController
                                                          .matchDetailsHeader
                                                          .value
                                                          .data
                                                          ?.teamAwayS ??
                                                      'Team 2',
                                                  style: TextStyle(
                                                    color: AppColors.text,
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
                                !matchDetailsController.isLoading2In.value &&
                                        matchDetailsController.matchLineUp.value
                                            .playerList!.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                            itemCount: matchDetailsController
                                                .matchLineUp
                                                .value
                                                .playerList!
                                                .length,
                                            itemBuilder: (context, i) {
                                              var lineUp =
                                                  matchDetailsController
                                                      .matchLineUp
                                                      .value
                                                      .playerList![i];
                                              return LineUpPlayerWidget(
                                                  lineUp: lineUp);
                                            }),
                                      )
                                    : Expanded(
                                        child: Center(
                                          child: Image.asset(
                                            AppAssets.loading,
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          )
                        : Center(
                            child: Image.asset(
                              AppAssets.loading,
                              height: 50,
                              width: 50,
                            ),
                          ),
                  if (!matchDetailsController.isLoading3.value &&
                      matchDetailsController
                          .matchCommentary.value.commentary!.isEmpty)
                    Center(
                      child: Text(
                        'Commentary Not Available!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else if (!matchDetailsController.isLoading3.value &&
                      matchDetailsController
                          .matchCommentary.value.commentary!.isNotEmpty)
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: AppSizes.newSize(30),
                          height: AppSizes.newSize(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.border,
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () {
                                    _tabController2!.animateTo(0);

                                    setState(() {
                                      matchDetailsController
                                          .currentIndex2.value = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: matchDetailsController
                                                  .currentIndex2.value ==
                                              0
                                          ? AppColors.background2
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Commentary',
                                          style: TextStyle(
                                            color: AppColors.text,
                                            fontSize: AppSizes.size13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () {
                                    _tabController2!.animateTo(1);
                                    setState(() {
                                      matchDetailsController
                                          .currentIndex2.value = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: matchDetailsController
                                                  .currentIndex2.value ==
                                              1
                                          ? AppColors.background2
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Key Commentary',
                                          style: TextStyle(
                                            color: AppColors.text,
                                            fontSize: AppSizes.size13,
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
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () {
                              matchDetailsController
                                  .loadMatchHeader(widget.arguments['matchId']);
                              return matchDetailsController
                                  .loadCommentary(widget.arguments['matchId']);
                            },
                            child: ListView.separated(
                                itemCount:
                                    matchDetailsController
                                                .currentIndex2.value ==
                                            0
                                        ? (matchDetailsController
                                            .matchCommentary
                                            .value
                                            .commentary!
                                            .length)
                                        : (matchDetailsController
                                            .matchCommentary
                                            .value
                                            .keyCommentary!
                                            .length),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                                itemBuilder: (context, i) {
                                  var commentary = matchDetailsController
                                              .currentIndex2.value ==
                                          0
                                      ? matchDetailsController
                                          .matchCommentary.value.commentary![i]
                                      : matchDetailsController.matchCommentary
                                          .value.keyCommentary![i];
                                  return CommentaryWidget(
                                      commentary: commentary);
                                }),
                          ),
                        ),
                      ],
                    )
                  else
                    Center(
                      child: Image.asset(
                        AppAssets.loading,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  if (!matchDetailsController.isLoading4.value &&
                      // ignore: unnecessary_null_comparison
                      matchDetailsController.matchStatistics.value == null)
                    Center(
                      child: Text(
                        'Statistics Not Available!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else if (!matchDetailsController.isLoading4.value &&
                      !matchDetailsController.hasMatchStatistics.value)
                    Center(
                      child: Text(
                        'Statistics Not Available!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else if (!matchDetailsController.isLoading4.value &&
                      matchDetailsController
                          .matchStatistics.value.info!.isNotEmpty)
                    RefreshIndicator(
                      onRefresh: () {
                        matchDetailsController
                            .loadMatchHeader(widget.arguments['matchId']);
                        return matchDetailsController
                            .loadStatistics(widget.arguments['matchId']);
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppSizes.newSize(54),
                              decoration:
                                  BoxDecoration(color: AppColors.background),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              matchDetailsController
                                                  .matchStatistics
                                                  .value
                                                  .team!
                                                  .homeTimg!,
                                              height: 30,
                                              width: 30,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              matchDetailsController
                                                  .matchStatistics
                                                  .value
                                                  .team!
                                                  .homeTname!,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'vs',
                                          style: TextStyle(
                                            fontSize: AppSizes.size14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.text,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              matchDetailsController
                                                  .matchStatistics
                                                  .value
                                                  .team!
                                                  .awayTname!,
                                              style: TextStyle(
                                                color: AppColors.text,
                                                fontSize: AppSizes.size15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Image.network(
                                              matchDetailsController
                                                  .matchStatistics
                                                  .value
                                                  .team!
                                                  .awayTimg!,
                                              height: 30,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.border,
                                          width: 0.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: AppSizes.newSize(42),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppColors.background2,
                                    ),
                                    child: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                            touchCallback:
                                                (FlTouchEvent? flTouchEvent,
                                                    PieTouchResponse?
                                                        pieTouchResponse) {
                                          setState(() {
                                            if (!flTouchEvent!
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              matchDetailsController
                                                  .touchedIndex.value = -1;
                                              return;
                                            }

                                            matchDetailsController
                                                    .touchedIndex.value =
                                                pieTouchResponse.touchedSection!
                                                    .touchedSectionIndex;
                                          });
                                        }),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: showingSections(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Indicator(
                                    color: Colors.green[400]!,
                                    text: matchDetailsController
                                        .matchStatistics.value.team!.homeTname!,
                                    isSquare: false,
                                    textColor: AppColors.text,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Indicator(
                                    color: AppColors.selected,
                                    text: matchDetailsController
                                        .matchStatistics.value.team!.awayTname!,
                                    isSquare: false,
                                    textColor: AppColors.text,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.border,
                                    width: 0.2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'VS',
                                  style: TextStyle(
                                    color: AppColors.text,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    matchDetailsController.matchStatistics.value
                                        .team!.graph!.homeShots!,
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: AppSizes.size18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 0.5,
                                    decoration: BoxDecoration(
                                      color: AppColors.text,
                                    ),
                                  ),
                                  Text(
                                    matchDetailsController.matchStatistics.value
                                        .team!.graph!.awayShots!,
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: AppSizes.size18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, bottom: 8),
                              child: Text(
                                'Information',
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontSize: AppSizes.size15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.background2,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.border,
                                          width: 0.2,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.network(
                                                matchDetailsController
                                                    .matchStatistics
                                                    .value
                                                    .team!
                                                    .homeTimg!,
                                                height: 30,
                                                width: 30,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                matchDetailsController
                                                    .matchStatistics
                                                    .value
                                                    .team!
                                                    .homeTname!,
                                                style: TextStyle(
                                                  color: AppColors.text,
                                                  fontSize: AppSizes.size13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                matchDetailsController
                                                    .matchStatistics
                                                    .value
                                                    .team!
                                                    .awayTname!,
                                                style: TextStyle(
                                                  color: AppColors.text,
                                                  fontSize: AppSizes.size13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Image.network(
                                                matchDetailsController
                                                    .matchStatistics
                                                    .value
                                                    .team!
                                                    .awayTimg!,
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (matchDetailsController
                                      .matchStatistics.value.info!.isNotEmpty)
                                    ...matchDetailsController
                                        .matchStatistics.value.info!
                                        .map(
                                      (e) => Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AppColors.border,
                                              width: 0.1,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.home ?? '',
                                                style: TextStyle(
                                                  color: AppColors.text,
                                                ),
                                              ),
                                              Text(
                                                e.problem ?? '',
                                                style: TextStyle(
                                                  color: AppColors.text,
                                                ),
                                              ),
                                              Text(
                                                e.away ?? '',
                                                style: TextStyle(
                                                  color: AppColors.text,
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
                          ],
                        ),
                      ),
                    )
                  else
                    Center(
                      child: Image.asset(
                        AppAssets.loading,
                        height: 50,
                        width: 50,
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == matchDetailsController.touchedIndex.value;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green[400],
            value: double.parse(matchDetailsController
                .matchStatistics.value.team!.graph!.homeChart!
                .replaceAll('%', '')),
            title:
                '${matchDetailsController.matchStatistics.value.team!.graph!.homeChart}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.selected,
            value: double.parse(matchDetailsController
                .matchStatistics.value.team!.graph!.awayChart!
                .replaceAll('%', '')),
            title:
                '${matchDetailsController.matchStatistics.value.team!.graph!.awayChart}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          return PieChartSectionData();
      }
    });
  }
}

class CommentaryWidget extends StatelessWidget {
  const CommentaryWidget({
    Key? key,
    required this.commentary,
  }) : super(key: key);

  final Commentary commentary;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Row(
        children: [
          Text(
            commentary.timeStamp!,
            style: TextStyle(
              color: AppColors.text,
              fontSize: AppSizes.size13,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(width: 10),
          if (commentary.iconFinder != '')
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                AppConsts.BASE_URL +
                    '/public/football/icon/' +
                    commentary.iconFinder!,
                height: 20,
                width: 20,
              ),
            )
          else
            const SizedBox(
              height: 20,
              width: 20,
            ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              commentary.gameDetails!,
              style: TextStyle(
                color: AppColors.text,
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
