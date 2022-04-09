// ignore_for_file: avoid_print

import 'package:big_soccer/services/custom_ad/services/api_services.dart';
import 'package:get/get.dart';
import '/controllers/setting_controller.dart';

import 'models/custom_ad.dart';
import 'views/custom_interstitial_ad.dart';

class CustomInterstitialAd {
  static bool isLoaded = false;
  static CustomAdModel? interstitialAd;
  static SettingController settingController = Get.find();
  static load() async {
    if (settingController.appAddsControl.value == "off") {
      return;
    }
    try {
      var response = await CustomAdApiService.loadAd('interstitial');
      if (response.status ?? false) {
        interstitialAd = response;
        isLoaded = true;
      }
    } catch (e) {
      print(e);
    }
  }

  static show({callback}) {
    if (interstitialAd?.status ?? false) {
      customInterstitialAd(
        Get.context!,
        interstitialAd!,
        onDismiss: () {
          callback();
          load();
        },
      );
    } else {
      callback();
    }
  }
}
