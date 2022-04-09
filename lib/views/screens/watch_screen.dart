// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:better_player/better_player.dart';
import 'package:big_soccer/views/screens/chats/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '/consts/consts.dart';
import '/controllers/setting_controller.dart';
import '/services/vpn_service.dart';
import 'package:wakelock/wakelock.dart';

class WatchScreen extends StatefulWidget {
  static const String route = '/watch_screen';

  final arguments;
  const WatchScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BetterPlayerController? _betterPlayerController;
  SettingController settingsController = Get.find<SettingController>();

  @override
  void initState() {
    Wakelock.enable();

    load();

    super.initState();
  }

  load() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      BetterPlayerConfiguration betterPlayerConfiguration =
          BetterPlayerConfiguration(
        errorBuilder: (BuildContext context, e) {
          Fluttertoast.showToast(
            msg: "This link is not playable, Try another one".tr,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
            // Do something
          });
          return const SizedBox();
        },
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        looping: true,
        allowedScreenSleep: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSkips: false,
          loadingWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.loading,
                width: 50,
                height: 50,
              )
            ],
          ),
          enableOverflowMenu: false,
        ),
        deviceOrientationsOnFullScreen: [DeviceOrientation.landscapeRight],
        fullScreenAspectRatio: 16 / 9,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        systemOverlaysAfterFullScreen: SystemUiOverlay.values,
      );

      BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.arguments['stream_url'],
        liveStream: true,
      );

      _betterPlayerController =
          BetterPlayerController(betterPlayerConfiguration);
      _betterPlayerController!.setupDataSource(dataSource);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.arguments['title'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: _betterPlayerController != null
                    ? BetterPlayer(controller: _betterPlayerController!)
                    : Image.asset(
                        AppAssets.loading,
                        width: 50,
                        height: 50,
                      ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red,
                      ),
                      child: Text(
                        "LIVE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.text2,
                          fontSize: AppSizes.size12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.transparent.withOpacity(0.6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: AppSizes.size12,
                            color: AppColors.text2,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('rooms')
                                .where('name',
                                    isEqualTo: 'match_' +
                                        widget.arguments['id'].toString())
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  (snapshot.data?.docs[0]['users'] ?? 1)
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text2,
                                    fontSize: AppSizes.size12,
                                  ),
                                );
                              }

                              return Text(
                                '1',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text2,
                                  fontSize: AppSizes.size12,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Chat(
              {'id': 'match_' + widget.arguments['id'].toString()},
            ),
          ),
        ],
      ),
      //bottomNavigationBar: PlayerAd(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController?.dispose();
    //_anchoredBanner!.dispose();
    Wakelock.disable();
  }
}
