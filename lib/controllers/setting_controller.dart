// ignore_for_file: unnecessary_overrides, unused_local_variable

import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as gs;
import 'package:package_info_plus/package_info_plus.dart';
import '/models/setting.dart';

class SettingController extends GetxController {
  var isLoading = true.obs;
  var settings = Data().obs;
  var adCount = 0.obs;
  var bannerPlacementId = ''.obs;
  var interstitialPlacementId = ''.obs;
  var promotionSliderIndex = 0.obs;
  var showRating = true.obs;
  // var appPublishingControl = true.obs;
  RxBool appPublishingControl = true.obs;
  var isDontShow = false.obs;
  RxBool notification = true.obs;
  RxInt sliderIndex = 0.obs;
  var screenIndex = 0.obs;
  RxInt currentTheme = 0.obs;
  RxString currentLanguage = 'English'.obs;
  RxBool isNew = true.obs;
  RxString appName = ''.obs;
  RxString appAddsControl = ''.obs;
  RxInt watchNow = 1.obs;

  @override
  void onInit() {
    super.onInit();

    //getAppStatus();
    getLanguage();
  }
  getLanguage() {
    var box = gs.GetStorage();
    var _lang = box.read('lng') ?? 'English';
    currentLanguage.value = _lang;
  }
  void store(Setting setting) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    settings.value = setting.data!;

    if (Platform.isAndroid) {
      appPublishingControl.value =
          (setting.data!.appPublishingControl ?? 'on') == 'off' ? true : false;
    } else {
      appPublishingControl.value =
          (setting.data!.iosAppPublishingControl ?? 'on') == 'off'
              ? true
              : false;
    }

    appName.value = packageInfo.appName;
    appAddsControl.value = setting.data!.adsControl ?? '';
  }


  // getAppStatus() {
  //   var box = GetStorage();

  //   var _status2 = box.read('notification') ?? true;
  //   notification.value = _status2;

  //   Future.delayed(const Duration(seconds: 2), () async {
  //     if (_status2) {
  //       await FirebaseMessaging.instance.subscribeToTopic('veva_live_football');
  //     }
  //   });
  // }

  // changeNotificationStatus() async {
  //   var box = GetStorage();
  //   box.write('notification', !notification.value);
  //   notification.value = !notification.value;

  //   if (notification.value) {
  //     await FirebaseMessaging.instance.subscribeToTopic('veva_live_football');
  //   } else {
  //     await FirebaseMessaging.instance
  //         .unsubscribeFromTopic('veva_live_football');
  //   }
  // }
}
