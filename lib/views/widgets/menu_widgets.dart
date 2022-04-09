// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:big_soccer/main.dart';
import 'package:big_soccer/views/screens/auth/phone_screen.dart';
import 'package:flutter/material.dart';
import '/consts/consts.dart';
import 'package:get/get.dart';

class UserProfileWidget extends StatelessWidget {
  final String userName;
  final String userNum;
  final String userEmail;

  const UserProfileWidget({
    Key? key,
    required this.userName,
    required this.userNum,
    required this.userEmail,
  }) : super(key: key);

  //AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        borderRadius: BorderRadius.circular(4),
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: AppColors.background2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAssets.DEFAULT_USER,
                  height: AppSizes.newSize(8),
                  width: AppSizes.newSize(8),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: AppSizes.size18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        userNum,
                        style: TextStyle(
                          fontSize: AppSizes.size13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //authController.logout();
                    Get.to(MyApp());
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8)
                            .copyWith(right: 20),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 0.1,
                          spreadRadius: 0.0,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Text(
                      "Log Out".tr.toUpperCase(),
                      style: TextStyle(
                        fontSize: AppSizes.size14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem1 extends StatelessWidget {
  final String icon;
  final String menuName;
  final String subMenuName;
  final callback;

  const MenuItem1({
    Key? key,
    required this.icon,
    required this.menuName,
    required this.subMenuName,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardColor,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon,
                    height: 30,
                    width: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuName,
                          style: TextStyle(
                            fontSize: AppSizes.size14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyText2!.color,
                          ),
                        ),
                        Text(
                          subMenuName,
                          style: TextStyle(
                            fontSize: AppSizes.size12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 15,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem2 extends StatelessWidget {
  final String icon;
  final String menuName;
  final callback;

  const MenuItem2({
    Key? key,
    required this.icon,
    required this.menuName,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  height: 30,
                  width: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    menuName,
                    style: TextStyle(
                      fontSize: AppSizes.size14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
