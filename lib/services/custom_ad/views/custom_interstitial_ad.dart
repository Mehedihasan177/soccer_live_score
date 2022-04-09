// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:animated_widgets/animated_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/custom_ad.dart';
import '/consts/consts.dart';
import '/utils/helpers.dart';

customInterstitialAd(BuildContext context, CustomAdModel customAd,
    {onDismiss}) {
  //use it

  print(customAd.data);

  //dd
  Future.delayed(
    Duration.zero,
    () {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Material(
                    color: Colors.transparent.withOpacity(0.8),
                    child: InkWell(
                      onTap: () {
                        launchURL(customAd.data?.actionUrl);
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  onDismiss();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TranslationAnimatedWidget(
                    duration: const Duration(milliseconds: 800),
                    enabled: true,
                    values: const [
                      Offset(0, 0),
                      Offset(0, 40),
                      Offset(0, 80),
                    ],
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    customAd.data!.title ?? '',
                                    style: TextStyle(
                                      fontSize: AppSizes.size14,
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    customAd.data!.shortDescription ?? '',
                                    style: TextStyle(
                                      fontSize: AppSizes.size12,
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              child: InkWell(
                                onTap: () {
                                  launchURL(customAd.data?.actionUrl);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    // ignore: prefer_const_literals_to_create_immutables
                                    boxShadow: [
                                      const BoxShadow(
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    customAd.data!.buttonText ?? '',
                                    style: TextStyle(
                                      fontSize: AppSizes.size12,
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  TranslationAnimatedWidget(
                    duration: const Duration(milliseconds: 800),
                    enabled: true,
                    values: [
                      Offset(0, Get.height),
                      Offset(0, Get.height - 200),
                      Offset(0, Get.height - 400),
                    ],
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          launchURL(customAd.data?.actionUrl);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          //color: Colors.green,
                          height: 350,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: customAd.data!.image ?? '',
                            height: 40,
                            width: 40,
                            placeholder: (context, url) => Container(
                              width: 20,
                              height: 20,
                              child: Image.asset(AppAssets.loading),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
