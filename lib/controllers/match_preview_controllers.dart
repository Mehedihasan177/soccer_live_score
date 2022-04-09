import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '/models/match_preview.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

class MatchPreviewController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  Rx<MatchPreview> matchPreview = MatchPreview().obs;
  RxBool hasTopScorers = false.obs;
  RxBool hasMostAssists = false.obs;
  RxBool hasHeadToHead = false.obs;
  RxBool hasHeader = false.obs;
  RxInt currentIndex = 0.obs;
  RxInt currentIndex2 = 0.obs;

  loadMatchPreview(matchId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadMatchPreview(matchId);
        if (response != MatchPreview()) {
          matchPreview.value = response;
          if (response.header!.gameTime!.isNotEmpty) {
            hasHeader.value = true;
          }
          if (response.topScorers.isNotEmpty) {
            hasTopScorers.value = true;
          }
          if (response.mostAssists.isNotEmpty) {
            hasMostAssists.value = true;
          }
          if (response.headToHead!.isNotEmpty) {
            hasHeadToHead.value = true;
          }
        } else {
          showSnackBar('Server error! Please try again.', 2);
        }
      } catch (e) {
        //showSnackBar(e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2);
    }
  }

  cDispose() {
    isLoading.value = true;
    isLoading2.value = true;
    matchPreview.value = MatchPreview();
    hasTopScorers.value = false;
    hasMostAssists.value = false;
    hasHeadToHead.value = false;
    hasHeader.value = false;
    currentIndex.value = 0;
    currentIndex2.value = 0;
  }
}
