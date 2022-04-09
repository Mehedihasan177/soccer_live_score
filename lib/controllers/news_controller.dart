// ignore_for_file: file_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '/models/football_news.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '../../utils/helpers.dart';

class NewsController extends GetxController {
  RxList<News>? news = <News>[].obs;
  //Rx<NewsDtls> newsDetails = NewsDtls().obs;

  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;

  loadFootballNews() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.laodFootballNews();
        news!.clear();
        news!.addAll(response.news!);
        isLoading.value = false;
      } catch (e) {
        showSnackBar(e.toString(), 200, () {
          loadFootballNews();
        });
      } finally {}
    } else {
      showSnackBar('No internet connection please try again!', 2, () {
        loadFootballNews();
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadFootballNews();
  }
}
