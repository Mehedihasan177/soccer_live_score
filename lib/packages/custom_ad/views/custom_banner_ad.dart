import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/setting_controller.dart';
import '../../../utils/helpers.dart';
import '/packages/custom_ad/models/custom_ad.dart';
import '/packages/custom_ad/services/api_services.dart';

class CustomBannerAd extends StatefulWidget {
  const CustomBannerAd({Key? key}) : super(key: key);

  @override
  _CustomBannerAdState createState() => _CustomBannerAdState();
}

class _CustomBannerAdState extends State<CustomBannerAd> {
  CustomAdModel? customAd;
  bool isLoaded = false;
  SettingController settingController = Get.find();

  loadAd() async {
     if (settingController.appAddsControl.value == "off") {
      return;
    }
    try {
      var response = await CustomAdApiService.loadAd('banner');
      if (response.status ?? false) {
        customAd = response;
        isLoaded = true;
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    //use it
    return isLoaded
        ? InkWell(
            onTap: () {
              launchURL(customAd!.data?.actionUrl);
            },
            child: Container(
              height: 60,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: customAd!.data!.image ?? '',
              ),
            ),
          )
        : SizedBox();
  }
}
