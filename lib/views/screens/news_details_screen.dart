// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:load/load.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '/consts/consts.dart';
import '/controllers/setting_controller.dart';

class NewsDatailsScreen extends StatefulWidget {
  final arguments;
  const NewsDatailsScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _NewsDatailsScreenState createState() => _NewsDatailsScreenState();
}

class _NewsDatailsScreenState extends State<NewsDatailsScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  SettingController settingsController = Get.find<SettingController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showCustomLoadingWidget(
        Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
        tapDismiss: false,
      );
    });
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background3,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        systemOverlayStyle: AppStyles.appbarOverlay(),
        backgroundColor: Colors.white,
        title: Text(
          'News Details'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size16,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.background,
        child: WebView(
          backgroundColor: AppColors.background,
          initialUrl: AppConsts.NEWS_DETAILS + widget.arguments['newsURL'],
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            hideLoadingDialog();
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
