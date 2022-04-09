// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/helpers.dart';
import '/views/screens/auth/register_screen.dart';
import '/controllers/auth_controller.dart';
import '/views/screens/auth/otp_screen.dart';

class PhoneAuthService {
  AuthController authController = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login(String phone, BuildContext context) async {
    authController.isLoading.value = true;
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 25),
      verificationCompleted: (AuthCredential credential) async {
        print('verificationCompleted');
        UserCredential result = await _auth.signInWithCredential(credential);

        User? user = result.user;

        if (user != null) {
          final Map<String, dynamic> data = <String, dynamic>{};
          data['uid'] = user.uid;
          data['name'] = user.displayName;
          data['image'] = user.photoURL;
          data['email'] = user.email;
          data['phone'] = user.phoneNumber;
          data['password'] = '';
          data['prodiver'] = 'phone';
          data['isCompleted'] = 'no';

          authController.saveUser(data);
          Get.to(() => const RegisterScreen());
        } else {
          print("Error");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        authController.isLoading.value = false;
        print(exception);
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        print(forceResendingToken.toString() + 'dddddd');
        Get.to(() =>
            OtpScreen({'verificationId': verificationId, 'phone': phone}));
        authController.isLoading.value = false;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId.toString() + 'dddddd');
      },
    );
  }

  verify(verificationId, otp) async {
    authController.isLoading2.value = true;
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      if (user != null) {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['uid'] = user.uid;
        data['name'] = user.displayName;
        data['image'] = user.photoURL;
        data['email'] = user.email;
        data['phone'] = user.phoneNumber;
        data['password'] = '';
        data['prodiver'] = 'phone';
        data['isCompleted'] = 'no';

        authController.saveUser(data);
        Get.to(() => const RegisterScreen());
      } else {
        print("Error");
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message.toString());
    } catch (e) {
      print(e);
    } finally {
      authController.isLoading2.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
