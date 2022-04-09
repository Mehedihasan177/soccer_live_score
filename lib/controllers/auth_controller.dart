// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:big_soccer/views/screens/auth/phone_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/services/api_services.dart';
import '/services/phone_auth_service.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

import '/models/user.dart';
import '/services/database_service.dart';
import '/services/email_auth_service.dart';

class AuthController extends GetxController {
  List<Color> colors = [
    Colors.red.shade700,
    Colors.yellow.shade600,
    Colors.purple.shade600,
    Colors.blue.shade600,
    Colors.pink.shade600
  ];
  RxBool isLoading = false.obs;
  RxBool isLoading2 = false.obs;
  RxBool isLogined = false.obs;
  Rx<UserModel> user = UserModel().obs;

  saveUser(data) {
    data['color'] = (colors.toList()..shuffle()).first.value;
    user.value = UserModel.fromJson(data);
    isLogined.value = true;
    var box = GetStorage();
    box.write('users', jsonEncode(data));
    DatabaseService().saveUserData(data);
  }

  loadUser() {
    var box = GetStorage();
    if (box.read('users') != null) {
      isLogined.value = true;
      user.value = UserModel.fromJson(jsonDecode(box.read('users')));
    }
  }

  logout() {
    if (user.value.prodiver == 'phone') {
      PhoneAuthService().logout();
    } else if (user.value.prodiver == 'email') {
      EmailAuthService().logout();
    }
    var box = GetStorage();
    box.remove('users');
    isLogined.value = false;
    Get.offAll(() => const PhoneScreen());
  }

  addUser(data) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.addUser(data);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      showSnackBar(
        'No internet connection please try again!',
        2,
        () {
          addUser(data);
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }
}
