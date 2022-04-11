import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import '../../services/custom_ad/custom_ad.dart';
import '/consts/consts.dart';
import '/controllers/match_preview_controllers.dart';
import '/controllers/setting_controller.dart';
import '/views/widgets/head_to_head_widget.dart';
import '/views/widgets/marquee_widget.dart';
import '/views/widgets/preview_player_widget.dart';
import '/views/widgets/sabt.dart';

class MatchPreviewScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final arguments;
  const MatchPreviewScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _MatchPreviewScreenState createState() => _MatchPreviewScreenState();
}

class _MatchPreviewScreenState extends State<MatchPreviewScreen>
    with TickerProviderStateMixin {
  MatchPreviewController matchController = Get.find<MatchPreviewController>();
  SettingController settingsController = Get.find<SettingController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      matchController.loadMatchPreview(widget.arguments['matchId']);
    });
  }

  @override
  void dispose() {
    super.dispose();
    matchController.cDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: BackButton(color: Colors.black),
              systemOverlayStyle: AppStyles.appbarOverlay(),
              backgroundColor: AppColors.background,
              primary: true,
              expandedHeight: AppSizes.newSize(25),
              floating: false,
              pinned: true,
              title: SABT(
                  child: SizedBox(
                height: 20,
                child: MarqueeWidget(
                  text: (matchController.matchPreview.value.header?.homeAway ??
                          'Home Team') +
                      ' vs ' +
                      (matchController.matchPreview.value.header?.tAway ??
                          'Away Team') +
                      ' - ' +
                      (matchController.matchPreview.value.header?.league ?? ''),
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  scrollAxis: Axis.horizontal,
                ),
              )),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Obx(() {
                  return Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 165),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.background,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: widget.arguments['homeImage'],
                                      width: AppSizes.newSize(5),
                                      height: AppSizes.newSize(5),
                                      placeholder: (context, url) => Container(
                                        width: AppSizes.newSize(5),
                                        padding: const EdgeInsets.all(5),
                                        height: AppSizes.newSize(5),
                                        child: Image.asset(AppAssets.loading),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        AppAssets.team,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      widget.arguments['homeName'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.text,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppSizes.size14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: widget.arguments['result'] != 'Postponed'
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'VS',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: AppSizes.size18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: widget.arguments['awayImage'],
                                      width: AppSizes.newSize(5),
                                      height: AppSizes.newSize(5),
                                      placeholder: (context, url) => Container(
                                        width: AppSizes.newSize(5),
                                        padding: const EdgeInsets.all(5),
                                        height: AppSizes.newSize(5),
                                        child: Image.asset(AppAssets.loading),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/default-team.png',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: Text(
                                        widget.arguments['awayName'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.text,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppSizes.size14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.values[2],
                          children: [
                            const SizedBox(height: 3),
                            if (widget.arguments['result'] != 'Postponed')
                              CountdownTimer(
                                widgetBuilder: (context, time) {
                                  if (time == null) {
                                    return Text(
                                      'Live/Complated',
                                      style: TextStyle(
                                        color: Colors.red[600],
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppSizes.size13,
                                      ),
                                    );
                                  }
                                  return Text(
                                    'Match start after ${time.days ?? '0'}d : ${time.hours ?? '0'}h : ${time.min ?? '0'}m : ${time.sec}s',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w400,
                                      fontSize: AppSizes.size14,
                                    ),
                                  );
                                },
                                endTime: int.parse(widget.arguments['result']) *
                                    1000,
                                textStyle: const TextStyle(
                                    fontSize: 30, color: Colors.pink),
                              )
                            else
                              Text(
                                'Postponed',
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSizes.size13,
                                ),
                              ),
                            const SizedBox(height: 3),
                            Text(
                              matchController
                                      .matchPreview.value.gameInfo?.vanue ??
                                  '',
                              style: const TextStyle(
                                color: AppColors.text,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ];
        },
        body: Obx(() {
          return !matchController.isLoading.value
              ? matchController.hasHeader.value
                  ? SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(children: [
                          if (!matchController.isLoading.value &&
                              !matchController.hasTopScorers.value &&
                              !matchController.hasMostAssists.value &&
                              !matchController.hasHeadToHead.value)
                            Container(
                              alignment: Alignment.center,
                              height: AppSizes.newSize(50.5),
                              child: const Text(
                                'No data available for this match!',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          if (!matchController.isLoading.value &&
                              matchController.hasTopScorers.value)
                            Center(
                              child: TopScorersWidget(
                                  matchController: matchController),
                            ),
                          const SizedBox(height: 5),
                          if (!matchController.isLoading.value &&
                              matchController.hasTopScorers.value)
                            Center(
                              child: MostAssistsWidget(
                                  matchController: matchController),
                            ),
                          const SizedBox(height: 5),
                          if (matchController.hasHeadToHead.value)
                            Align(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                  left: 2,
                                  right: 2,
                                ),
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.only(left: 3, right: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.background2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Head To Head',
                                        style: TextStyle(
                                          fontSize: AppSizes.size14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.text,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: AppColors.border,
                                      height: 0.2,
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: !matchController
                                                  .isLoading.value &&
                                              matchController.matchPreview.value
                                                  .headToHead!.isNotEmpty
                                          ? matchController
                                              .matchPreview.value.headToHead!
                                              .map(
                                                (e) => HeadToHeadWidget(e: e),
                                              )
                                              .toList()
                                          : [],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                        ]),
                      ),
                    )
                  : const SizedBox()
              : Center(
                  child: Image.asset(
                    AppAssets.loading,
                    height: 50,
                    width: 50,
                  ),
                );
        }),
      ),
      bottomNavigationBar: const CustomBannerAd(),
    );
  }
}

class TopScorersWidget extends StatelessWidget {
  const TopScorersWidget({
    Key? key,
    required this.matchController,
  }) : super(key: key);

  final MatchPreviewController matchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 3, right: 3, bottom: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.background2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Top Scorers'.toUpperCase(),
              style: TextStyle(
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.2, color: AppColors.border),
              ),
            ),
          ),
          Align(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 240,
              decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: AppColors.border),
              ),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          matchController.currentIndex.value = 0;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: matchController.currentIndex.value == 0
                                ? AppColors.background
                                : Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                matchController
                                    .matchPreview.value.header!.tHomeImg!,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                matchController
                                    .matchPreview.value.header!.tHomeSnm!,
                                style: const TextStyle(
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
                          matchController.currentIndex.value = 1;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: matchController.currentIndex.value == 1
                                ? AppColors.background
                                : Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                matchController
                                    .matchPreview.value.header!.tAwayImg!,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                matchController
                                    .matchPreview.value.header!.tAwaySnm!,
                                style: const TextStyle(
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: matchController.currentIndex.value == 0,
              child: (matchController.matchPreview.value.topScorers.length > 0)
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: matchController
                          .matchPreview.value.topScorers[0].length,
                      itemBuilder: (context, index) {
                        var e = matchController.matchPreview.value.topScorers[0]
                            [index];
                        return PreviewPlayerWidget(e: e);
                      })
                  : Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        'No Player available',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: AppSizes.size13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            );
          }),
          Obx(() {
            return Visibility(
              visible: matchController.currentIndex.value == 1,
              child: (matchController.matchPreview.value.topScorers.length > 1)
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: matchController
                          .matchPreview.value.topScorers[1].length,
                      itemBuilder: (context, index) {
                        var e = matchController.matchPreview.value.topScorers[1]
                            [index];
                        return PreviewPlayerWidget(e: e);
                      })
                  : Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        'No Player available',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: AppSizes.size13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            );
          }),
        ],
      ),
    );
  }
}

class MostAssistsWidget extends StatelessWidget {
  const MostAssistsWidget({
    Key? key,
    required this.matchController,
  }) : super(key: key);

  final MatchPreviewController matchController;

  @override
  Widget build(BuildContext context) {
    //kk
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3, bottom: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.background2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Most Assists'.toUpperCase(),
              style: TextStyle(
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.2, color: AppColors.border),
              ),
            ),
          ),
          Align(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 240,
              decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: AppColors.border),
              ),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          matchController.currentIndex2.value = 0;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: matchController.currentIndex2.value == 0
                                ? AppColors.background
                                : Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                matchController
                                    .matchPreview.value.header!.tHomeImg!,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                matchController
                                    .matchPreview.value.header!.tHomeSnm!,
                                style: const TextStyle(
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
                          matchController.currentIndex2.value = 1;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: matchController.currentIndex2.value == 1
                                ? AppColors.background
                                : Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                matchController
                                    .matchPreview.value.header!.tAwayImg!,
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                matchController
                                    .matchPreview.value.header!.tAwaySnm!,
                                style: const TextStyle(
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: matchController.currentIndex2.value == 0,
              child: (matchController.matchPreview.value.mostAssists.length > 0)
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: matchController
                          .matchPreview.value.mostAssists[0].length,
                      itemBuilder: (context, index) {
                        var e = matchController
                            .matchPreview.value.mostAssists[0][index];
                        return PreviewPlayerWidget(e: e);
                      })
                  : Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        'No Player available',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: AppSizes.size13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            );
          }),
          Obx(() {
            return Visibility(
              visible: matchController.currentIndex2.value == 1,
              child: (matchController.matchPreview.value.mostAssists.length > 1)
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: matchController
                          .matchPreview.value.mostAssists[1].length,
                      itemBuilder: (context, index) {
                        var e = matchController
                            .matchPreview.value.mostAssists[1][index];
                        return PreviewPlayerWidget(e: e);
                      })
                  : Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        'No Player available',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: AppSizes.size13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
