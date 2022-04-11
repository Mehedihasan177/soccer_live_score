// ignore_for_file: sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/utils/helpers.dart';
import '/controllers/auth_controller.dart';
import '/services/phone_auth_service.dart';
import '/consts/consts.dart';

class OtpScreen extends StatefulWidget {
  final arguments;
  const OtpScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController authController = Get.find();
  final _otpController = TextEditingController();
  final _otp2Controller = TextEditingController();
  final _otp3Controller = TextEditingController();
  final _otp4Controller = TextEditingController();
  final _otp5Controller = TextEditingController();
  final _otp6Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.blue,
      appBar: PreferredSize(
        preferredSize: new Size(0.0, 0.0),
        child: AppBar(
          systemOverlayStyle: AppStyles.appbarOverlay(),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: Get.height,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Icon(
                          Icons.arrow_back,
                          size: AppSizes.size20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AppAssets.OTP_SVG,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Confirm Phone Number'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Type 6 digit code sent to this number ".tr +
                        widget.arguments['phone'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _textFieldOTP(
                                first: true,
                                last: false,
                                controller: _otpController,
                              ),
                              _textFieldOTP(
                                first: false,
                                last: false,
                                controller: _otp2Controller,
                              ),
                              _textFieldOTP(
                                first: false,
                                last: false,
                                controller: _otp3Controller,
                              ),
                              _textFieldOTP(
                                first: false,
                                last: false,
                                controller: _otp4Controller,
                              ),
                              _textFieldOTP(
                                first: false,
                                last: false,
                                controller: _otp5Controller,
                              ),
                              _textFieldOTP(
                                first: false,
                                last: true,
                                controller: _otp6Controller,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final otp = _otpController.text.trim() +
                                    _otp2Controller.text.trim() +
                                    _otp3Controller.text.trim() +
                                    _otp4Controller.text.trim() +
                                    _otp5Controller.text.trim() +
                                    _otp6Controller.text.trim();
                                if (otp.length == 6) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');

                                  PhoneAuthService().verify(
                                    widget.arguments['verificationId'],
                                    otp,
                                  );
                                } else {
                                  showToast('Please enter full OTP code'.tr);
                                }
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.primaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              child: Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: !authController.isLoading2.value
                                      ? Text(
                                          'Verify'.tr,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        )
                                      : SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: AppColors.blue
                                          ),
                                        ),
                                );
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  if (_start > 0)
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Resend code in: ".tr,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: AppSizes.size14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            " $_start".tr,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: AppSizes.size13,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  if (_start == 0)
                    InkWell(
                      onTap: () {
                        PhoneAuthService().login(
                          widget.arguments['phone'],
                          context,
                        );
                        setState(() {
                          _start = 30;
                        });
                        startTimer();
                      },
                      child: Text(
                        "Resend again".tr,
                        style: TextStyle(
                          fontSize: AppSizes.size16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool? first, last, TextEditingController? controller}) {
    return Container(
      height: AppSizes.newSize(6.5),
      width: AppSizes.newSize(5.0),
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
          //code += value;
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.8,
              color: AppColors.border,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.8,
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
