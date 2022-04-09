import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '/models/prediction.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

class PredictionController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<Prediction> prediction = Prediction().obs;

  @override
  void onInit() {
    super.onInit();
    loadPrediction();
  }

  loadPrediction() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.laodPrediction();

        prediction.value = response;

        isLoading.value = false;
      } catch (e) {
        showSnackBar(
          'Server error! Please try again.',
          2,
          () {
            loadPrediction();
          },
        );
      }
    } else {
      showSnackBar(
        'No internet connection please try again!',
        2,
        () {
          loadPrediction();
        },
      );
    }
  }
}
