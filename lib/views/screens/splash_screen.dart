import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/consts/consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: new Size(0.0, 0.0),
        child: AppBar(
          systemOverlayStyle: AppStyles.appbarOverlay(),
          backgroundColor: Colors.transparent,
        ),
      ),
      backgroundColor: AppColors.blue,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/main_logo.png',
                  height: 220,
                ),
              ),
            ),
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.text,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
