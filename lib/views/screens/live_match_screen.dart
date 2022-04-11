// ignore_for_file: avoid_unnecessary_containers

import 'package:big_soccer/views/screens/watch_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/live_matches.dart';
import '../../services/custom_ad/custom_ad.dart';
import '/consts/consts.dart';
import '/controllers/live_match_controller.dart';

class LiveMatchScreen extends StatefulWidget {
  const LiveMatchScreen({Key? key}) : super(key: key);

  @override
  _LiveMatchScreenState createState() => _LiveMatchScreenState();
}

class _LiveMatchScreenState extends State<LiveMatchScreen> {
  LiveMatchController liveMatchController = Get.find();

  @override
  void initState() {
    super.initState();

    liveMatchController.loadMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      child: Center(
        child: Container(
          child: Obx(() {
            return RefreshIndicator(
              onRefresh: () => liveMatchController.loadMatches(),
              child: !liveMatchController.isLoading.value
                  ? (liveMatchController.liveMatches.value.data?.length ?? 0) >
                          0
                      ? ListView.builder(
                          itemCount: liveMatchController
                                  .liveMatches.value.data?.length ??
                              0,
                          itemBuilder: (context, index) {
                            Data liveMatcheItem = liveMatchController
                                .liveMatches.value.data![index];
                            return liveVideoMatchWidget(liveMatcheItem);
                          },
                        )
                      : SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: AppSizes.newSize(70),
                            child: Text(
                              'No match is live now, Try after sometime. \n Thanks!'
                                  .tr,
                              style: AppStyles.heading.copyWith(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
            );
          }),
        ),
      ),
    );
  }

  Widget liveVideoMatchWidget(Data liveMatcheItem) {
    return InkWell(
      onTap: () {
        var arguments = {
          'id': liveMatcheItem.id,
          'title': liveMatcheItem.matchTitle,
          'stream_url': liveMatcheItem.streamUrl,
        };

        CustomInterstitialAd.show(callback: () {
          Get.to(() => WatchScreen(arguments));
        });
      },
      child: Card(
        color: AppColors.background2,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                liveMatcheItem.matchTitle ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 3, 0, 8),
              height: 1,
              color: Colors.black,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: teamWidget(liveMatcheItem.teamOneImage ?? '',
                        liveMatcheItem.teamOneName ?? ''),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "VS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: AppSizes.size14,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: teamWidget(liveMatcheItem.teamTwoImage ?? '',
                        liveMatcheItem.teamTwoName ?? ''),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange,
                ),
                child: Text(
                  "WATCH LIVE".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget teamWidget(var teamImg, var teamName) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: teamImg ?? '',
          height: 3.8 * screenSize / 100,
          width: 3.8 * screenSize / 100,
          errorWidget: (context, url, error) {
            return Image.asset(AppAssets.DEFAULT_USER);
          },
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SizedBox(
              height: 2 * screenSize / 100,
              width: 2 * screenSize / 100,
              child: Image.asset(AppAssets.loading),
            ),
          ),
        ),
        Text(
          teamName,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: AppSizes.size14,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
