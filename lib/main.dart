// ignore_for_file: avoid_print

import 'dart:io';

import 'package:big_soccer/services/language_changes/localization_service.dart';
import 'package:big_soccer/views/screens/auth/phone_screen.dart';
import 'package:big_soccer/views/screens/auth/register_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '/controllers/live_match_controller.dart';
import '/controllers/match_details_controller.dart';
import '/controllers/match_preview_controllers.dart';
import '/consts/consts.dart';
import '/views/screens/parent_screen.dart';
import '/controllers/setting_controller.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';
import '/views/screens/splash_screen.dart';
import 'controllers/auth_controller.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);
  OneSignal.shared.setAppId('2021f458-ce93-465c-979b-34a6ff164320');
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      translations: LocalizationService(),
      locale: LocalizationService().getCurrentLocale(),
      fallbackLocale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        primaryColor: AppColors.primaryColor,
        fontFamily: GoogleFonts.hind().fontFamily,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.primaryColor,
        ),
      ),
      title: 'Live Soccer Score',
      onInit: () {
        Get.put(AuthController());
        Get.put(SettingController());
        Get.put(MatchPreviewController());
        Get.put(MatchDetailsController());
        Get.put(LiveMatchController());
      },
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController authController = Get.find();
  SettingController settingController = Get.find();

  var hasNotification = false;

  late Map arguments;

  @override
  void initState() {
    super.initState();

    initSingal();
    loadData();
  }

  void initSingal() async {
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var data = result.notification.additionalData!;

      if (data['notification_type'] == 'news') {}

      if (data['notification_type'] == 'url') {
        launchURL(data['action_url']);
      }

      if (data['notification_type'] == 'inApp') {}
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      setState(() {});
    });
  }

  loadData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadSettings();
        if (response.status == true) {
          settingController.store(response);
          if (Platform.isAndroid) {
            if (response.data!.appPublishingControl == 'on') {
              Get.offAll(() => const ParentScreen());
            } else {
              if (settingController.appPublishingControl.value) {
                if (authController.isLogined.value) {
                  if (authController.user.value.isCompleted == 'yes') {
                    Get.offAll(() => const ParentScreen());
                  } else {
                    Get.offAll(() => const RegisterScreen());
                  }
                } else {
                  Get.offAll(() => const PhoneScreen());
                }
              } else {
                Get.offAll(() => const ParentScreen());
              }
            }
          } else {
            if (response.data!.iosAppPublishingControl == 'on') {
              Get.offAll(() => const ParentScreen());
            } else {
              if (settingController.appPublishingControl.value) {
                if (authController.isLogined.value) {
                  if (authController.user.value.isCompleted == 'yes') {
                    Get.offAll(() => const ParentScreen());
                  } else {
                    Get.offAll(() => const RegisterScreen());
                  }
                } else {
                  Get.offAll(() => const PhoneScreen());
                }
              } else {
                Get.offAll(() => const ParentScreen());
              }
            }
          }
        } else {
          showSnackBar('Server Error! Please Try again.'.tr);
        }
      } catch (e) {
        showSnackBar('Server Error! Please Try again.'.tr);
      }
    } else {
      showSnackBar('No internet connection please try again!'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: const SplashScreen(),
    );
  }
}
