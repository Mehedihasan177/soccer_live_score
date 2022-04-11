import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/controllers/setting_controller.dart';
import '/controllers/auth_controller.dart';
import '/consts/consts.dart';
import '/services/phone_auth_service.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  AuthController authController = Get.find();
  SettingController settingController = Get.find();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isNumValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: new Size(0.0, 0.0),
        child: AppBar(
          systemOverlayStyle: AppStyles.appbarOverlay(),
          backgroundColor: Colors.transparent,
        ),
      ),
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: Get.height,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                        AppAssets.PHONE,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Obx(() {
                      return Text(
                        'Get started with '.tr +
                            settingController.appName.value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Add your phone number. we'll send you a verification code so we know you're real"
                          .tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
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
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _phoneController,
                            autofocus: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            maxLength: 9,
                            style: TextStyle(
                              fontSize: AppSizes.size16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              counterText: '',
                              prefix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '(+84)',
                                  style: TextStyle(
                                    fontSize: AppSizes.size15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              suffixIcon: isNumValidate
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: AppSizes.size22,
                                    )
                                  : const SizedBox(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number'.tr;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value.length == 9) {
                                setState(() {
                                  isNumValidate = true;
                                });
                              } else {
                                setState(() {
                                  isNumValidate = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final phone =
                                      '+84' + _phoneController.text.trim();

                                  PhoneAuthService().login(phone, context);
                                }
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
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
                                  child: !authController.isLoading.value
                                      ? Text(
                                          'Send'.tr,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        )
                                      :  SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: AppColors.text
                                          ),
                                        ),
                                );
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
