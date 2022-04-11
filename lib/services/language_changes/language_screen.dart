// ignore_for_file: avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/app_colors.dart';
import '../../controllers/setting_controller.dart';
import 'localization_service.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.blue1,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          'Languages'.tr,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
            height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              //controller: _scrollController,
              itemCount: LocalizationService.langs.length,
              itemBuilder: (context, index) {
                var data = LocalizationService.langs[index];

                return LanguageWidget(
                  name: data,
                  isSelected: data == settingController.currentLanguage.value,
                  callback: () {
                    settingController.currentLanguage.value = data;
                    LocalizationService().changeLocale(data);
                  },
                );
              },
            ),
          ),

    );
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    Key? key,
    required this.isSelected,
    required this.name,
    this.callback,
  }) : super(key: key);

  final bool isSelected;
  final String name;
  final callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ).copyWith(right: 15, left: 5),
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.2,
              color: Colors.white,
            ),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  // color: Theme.of(context).textTheme.bodyText2!.color,
                  color: Colors.black
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check,
                  size: 20,
                  // color: Theme.of(context).textTheme.bodyText2!.color,
                  color: Colors.black,
                ),
            ],
          ),

      ),
    );
  }
}
