import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '/models/match_commentary.dart';
import '/models/match_details_header.dart';
import '/models/match_line_up.dart';
import '/models/match_statistics.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

class MatchDetailsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  RxBool isLoading2In = true.obs;
  RxBool isLoading3 = true.obs;
  RxBool isLoading4 = true.obs;
  RxBool hasMatchStatistics = false.obs;
  RxBool hasMatchDetailsHeader = false.obs;
  Rx<MatchDetailsHeader> matchDetailsHeader = MatchDetailsHeader().obs;
  Rx<MatchLineUp> matchLineUp = MatchLineUp().obs;
  Rx<MatchCommentary> matchCommentary = MatchCommentary().obs;
  Rx<MatchStatistics> matchStatistics = MatchStatistics().obs;
  RxInt currentIndex = 0.obs;
  RxInt currentIndex2 = 0.obs;
  RxInt teamIndex = 0.obs;
  RxInt touchedIndex = 0.obs;
  List playerList = [].obs;

  loadMatchHeader(matchId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadMatchHeader(matchId);
        if (response != MatchDetailsHeader()) {
          matchDetailsHeader.value = response;

          if (response.data!.gamePlay!.isEmpty) {
            hasMatchDetailsHeader.value = true;
          }

          loadCommentary(matchId);
        } else {
          showSnackBar('Server error! Please try again.333', 2);
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.3333', 2);
      } finally {
        // hideLoadingDialog();
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2);
    }
  }

  loadLineUp(matchId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var response = await ApiService.loadLineUp(matchId, teamIndex.value);
        if (response != MatchLineUp()) {
          matchLineUp.value = response;
          if (response.playerList!.isNotEmpty) {
            playerList.clear();
            playerList.addAll(response.playerList!);
          }
        } else {
          showSnackBar('Server error! Please try againss.', 2);
        }
      } catch (e) {
        showSnackBar(e.toString());
      } finally {
        isLoading2.value = false;
        isLoading2In.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2);
    }
  }

  loadCommentary(matchId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var response = await ApiService.loadCommentary(matchId);
        //print(jsonEncode(response));
        if (response != MatchCommentary()) {
          matchCommentary.value = response;
        } else {
          showSnackBar('Server error! Please try again.', 2);
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2);
      } finally {
        isLoading3.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2);
    }
  }

  loadStatistics(matchId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var response = await ApiService.loadStatistics(matchId);
        if (response != MatchStatistics()) {
          matchStatistics.value = response;

          if (matchStatistics.value.info!.isNotEmpty) {
            hasMatchStatistics.value = true;
          }
        } else {
          showSnackBar('Server error! Please try again.', 2);
        }
      } catch (e) {
        //showSnackBar('Server error! Please try again.');
      } finally {
        isLoading4.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2);
    }
  }

  cDispose() {
    isLoading.value = true;
    isLoading2.value = true;
    isLoading2In.value = true;
    isLoading3.value = true;
    isLoading4.value = true;
    hasMatchStatistics.value = false;
    hasMatchDetailsHeader.value = false;
    matchDetailsHeader.value = MatchDetailsHeader();
    matchLineUp.value = MatchLineUp();
    matchCommentary.value = MatchCommentary();
    matchStatistics.value = MatchStatistics();
    currentIndex.value = 0;
    currentIndex2.value = 0;
    teamIndex.value = 0;
    touchedIndex.value = 0;
    playerList = [];
  }
}
