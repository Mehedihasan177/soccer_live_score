// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:load/load.dart';
import 'package:url_launcher/url_launcher.dart';
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
      backgroundColor: AppColors.text,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        systemOverlayStyle: AppStyles.appbarOverlay(),
        backgroundColor: AppColors.blue1,
        title: Text(
          'News Details'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size16,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child:  CachedNetworkImage(
                imageUrl: widget.arguments['newsImage'],
                imageBuilder: (context, imageProvider) =>
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppAssets.loading,
                    height: 60,
                    width: 60,
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error),
                fit: BoxFit.fill,
                width: double.infinity,
                height: 220,
              ),

          ),

          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              child: Center(
                  child: Text(
                    widget.arguments['newsTitle'],
                    style: TextStyle(
                      fontSize: AppSizes.size15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),

            ),
          ),
          Expanded(
            flex: 6,
            child: WebView(
                        backgroundColor: AppColors.blue,
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
        ],
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
