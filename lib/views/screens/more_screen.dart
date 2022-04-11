import 'package:big_soccer/services/language_changes/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../services/language_changes/localization_service.dart';
import '../widgets/menu_widgets.dart';
import '/consts/consts.dart';
import '/controllers/setting_controller.dart';
import '/utils/helpers.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  AuthController authController = Get.find();
  SettingController settingController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 6,
        ),
        children: [
          Obx(() {
            return Column(
              children: [
                if (settingController.appPublishingControl.value)
                  if (authController.isLogined.value)
                    UserProfileWidget(
                      userName: authController.user.value.name ?? '',
                      userNum: authController.user.value.phone ?? '',
                      userEmail: authController.user.value.email ?? '',
                    ),
              ],
            );
          }),
          InkWell(
            onTap: () {
              Get.to(() => const LanguageScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                    color: AppColors.background2,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      const SizedBox(width: 7),
                      Image.asset(AppAssets.Languages, height: 29,),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Language'.tr,
                            style: TextStyle(
                              fontSize: AppSizes.size15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Obx(() {
                            return Text(
                              settingController.currentLanguage.value,
                              style: TextStyle(
                                fontSize: AppSizes.size13,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              "Visit".tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: AppSizes.size16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: AppColors.background2,
                ),
              ],
            ),
            child: Column(
              children: [
                MenuItem2(
                  icon: AppAssets.FACEBOOK,
                  menuName: "Facebook".tr,
                  callback: () {
                    launchURL(settingController.settings.value.facebook);
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 0.1,
                  color: Colors.black,
                ),
                MenuItem2(
                  icon: AppAssets.TELEGRAM,
                  menuName: "Telegram".tr,
                  callback: () {
                    launchURL(settingController.settings.value.telegram);
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 0.1,
                  color: Colors.black,
                ),
                MenuItem2(
                  icon: AppAssets.YOUTUBE,
                  menuName: "YouTube".tr,
                  callback: () {
                    launchURL(settingController.settings.value.youtube);
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              "Support".tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: AppSizes.size16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: AppColors.background2,
                ),
              ],
            ),
            child: Column(
              children: [
                MenuItem2(
                  icon: AppAssets.SHARE,
                  menuName: "Invite Friends".tr,
                  callback: () async {
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    launchURL('https://play.google.com/store/apps/details?id=' +
                        packageInfo.packageName);
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 0.1,
                  color: Colors.black,
                ),
                MenuItem2(
                  icon: AppAssets.RATING,
                  menuName: "Rate & Review".tr,
                  callback: () async {
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    launchURL('https://play.google.com/store/apps/details?id=' +
                        packageInfo.packageName);
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 0.1,
                  color: Colors.black,
                ),
                MenuItem2(
                  icon: AppAssets.APP_UPDATE,
                  menuName: "Check for updates".tr,
                  callback: () async {
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    launchURL('https://play.google.com/store/apps/details?id=' +
                        packageInfo.packageName);
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 0.1,
                  color: Colors.black,
                ),
                MenuItem2(
                  icon: AppAssets.PRIVACY,
                  menuName: "Privacy Policy".tr,
                  callback: () {
                    launchURL(settingController.settings.value.privacyPolicy);
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}
