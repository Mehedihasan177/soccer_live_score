import 'package:big_soccer/models/live_matches.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

class LiveMatchController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<LiveMatches> liveMatches = LiveMatches().obs;
  RxBool isLoading2 = true.obs;
  RxBool isLoading3 = true.obs;

  loadMatches() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadLiveMatches();

        liveMatches.value = response;

        isLoading.value = false;
      } catch (e) {
        showSnackBar(
          'Server error! Please try again.',
          2,
          () {
            loadMatches();
          },
        );
      }
    } else {
      showSnackBar(
        'No internet connection please try again!',
        2,
        () {
          loadMatches();
        },
      );
    }
  }
  
}
