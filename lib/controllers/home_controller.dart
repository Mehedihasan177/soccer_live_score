import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/models/match_schedule.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

class HomeController extends GetxController {
  Rx<DateTime> selectedValue = DateTime.now().obs;
  RxList<RexFix> schedule = <RexFix>[].obs;
  RxBool isLoading = true.obs;
  RxString type = 'ALL'.obs;

  loadLeagues() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        String date = DateFormat('yyyyMMdd').format(selectedValue.value);
        var response = await ApiService.loadFootballSchedule(date, type.value);

        schedule.value = response.rexFix!;

        isLoading.value = false;
      } catch (e) {
        showSnackBar(
          e.toString(),
          2,
          () {
            loadLeagues();
          },
        );
      }
    } else {
      showSnackBar(
        'No internet connection please try again!',
        2,
        () {
          loadLeagues();
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadLeagues();
  }
}
