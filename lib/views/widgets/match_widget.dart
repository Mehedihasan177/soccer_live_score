import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/consts/consts.dart';
import '/views/screens/watch_screen.dart';

import '/models/live_match.dart';

class MatchWidget extends StatelessWidget {
  const MatchWidget({
    Key? key,
    required this.match,
  }) : super(key: key);

  final Data? match;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        child: ClipRect(
          child: Container(
            height: AppSizes.newSize(18),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.background2,
              border: Border.all(
                //color: AppColors.background,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Text(
                  match?.matchTitle ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSizes.size13,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: match?.teamOneImage ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: AppSizes.newSize(5),
                                height: AppSizes.newSize(5),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                width: AppSizes.newSize(5),
                                padding: const EdgeInsets.all(5),
                                height: AppSizes.newSize(5),
                                child: Image.asset(AppAssets.loading),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            SizedBox(height: AppSizes.size12),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  match?.teamOneName ?? '',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: AppSizes.size13,
                                    color: AppColors.text,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'VS',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppSizes.size13,
                                  color: AppColors.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: AppColors.selected,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              child: Text(
                                'Watch Now',
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSizes.size12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: match?.teamTwoImage ?? '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: AppSizes.newSize(5),
                                height: AppSizes.newSize(5),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                width: AppSizes.newSize(5),
                                padding: const EdgeInsets.all(5),
                                height: AppSizes.newSize(5),
                                child: Image.asset(AppAssets.loading),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            SizedBox(height: AppSizes.size12),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  match?.teamTwoName ?? '',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: AppSizes.size13,
                                    color: AppColors.text,
                                    fontWeight: FontWeight.bold,
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
                CountdownTimer(
                  endTime: int.parse(match?.matchTime ?? '') * 1000,
                  widgetBuilder: (_, time) {
                    // ignore: unnecessary_null_comparison
                    if (time == null) {
                      return Text(
                        DateFormat('dd MMM, yyyy hh:mm:a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            int.parse(match?.matchTime ?? '') * 1000,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.size13,
                        ),
                      );
                    }
                    return Text(
                      'Match will start after ${time.days ?? '0'}d : ${time.hours ?? '0'}h : ${time.min ?? '0'}m : ${time.sec}s',
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSizes.size13,
                      ),
                    );
                    // return Text(
                    //     'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onClick() {
    if ((match?.streamingSources?.length ?? 0) == 1) {
      var arguments = {
        'source': match?.streamingSources?[0],
      };
      Get.to(() => WatchScreen(arguments));
      return;
    }
    Get.bottomSheet(
      Container(
        height: AppSizes.newSize(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: AppColors.background,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.1,
                    color: Colors.grey,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Select sources',
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size18,
                ),
              ),
            ),
            if ((match?.streamingSources?.length ?? 0) == 0)
              const Expanded(
                child: Center(
                  child: Text(
                    'No Streaming Sources',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            if ((match?.streamingSources?.length ?? 0) > 0)
              Expanded(
                child: ListView.builder(
                  itemCount: (match?.streamingSources?.length ?? 0),
                  itemBuilder: (context, index) {
                    var source = match?.streamingSources?[index];
                    return TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        // minimumSize: Size(50, 30),
                        // alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        var arguments = {
                          'source': source,
                        };
                        Get.to(() => WatchScreen(arguments));
                      },
                      child: Container(
                        //alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.newSize(4),
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.1,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  source?.streamTitle ?? '',
                                  style: TextStyle(
                                    fontSize: AppSizes.size13,
                                    color: AppColors.text,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.play_circle_outlined,
                              color: AppColors.selected,
                              size: AppSizes.newSize(3.5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
