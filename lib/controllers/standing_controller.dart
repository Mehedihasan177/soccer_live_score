import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '/models/standing_leagues.dart';
import '/models/standing_years.dart';
import '/models/standings.dart';
import '/services/api_services.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

class StandingController extends GetxController {
  RxList<League> leagues = <League>[].obs;
  RxList<League> searchResult = <League>[].obs;
  RxString query = ''.obs;
  Rx<StandingYears> standingYears = StandingYears().obs;
  RxList<String> years = <String>[].obs;

  RxString dropdownValue = ''.obs;
  RxString selectedLink = ''.obs;
  RxList teams = [].obs;
  RxList points = [].obs;

  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  RxBool isLoading3 = true.obs;

  loadStandingLeagues() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await ApiService.loadStandingLeagues();
        if (response != StandingLeague()) {
          leagues.clear();
          if ((response.league?.length ?? 0) > 0) {
            for (var v in response.league!) {
              leagues.add(v);
            }
          }
        } else {
          showSnackBar('Server error! Please try again.666', 2, () {
            loadStandingLeagues();
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.666', 2, () {
          loadStandingLeagues();
        });
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {
        loadStandingLeagues();
      });
    }
  }

  onSearchTextChanged(String text) async {
    query.value = text;
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    for (var data in leagues) {
      if (data.name!.toLowerCase().contains(text) ||
          data.name!.toUpperCase().contains(text)) searchResult.add(data);
    }
  }

  loadStandingYears(link) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var response = await ApiService.loadStandingYears(link);
        if (response != StandingYears() && response.year!.isNotEmpty) {
          dropdownValue.value = response.year![0].year ?? '';
          selectedLink.value = response.year![0].link ?? '';
          for (var v in response.year!) {
            years.add(v.year ?? '');
          }
          loadStandings();
          standingYears.value = response;
        } else {
          showSnackBar('Server error! Please try again.', 2, () {
            isLoading2.value = true;
            loadStandingYears(link);
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {
          isLoading2.value = true;
          loadStandingYears(link);
        });
      } finally {
        isLoading2.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {
        loadStandingYears(link);
      });
    }
  }

  loadStandings() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var response = await ApiService.loadStandings(selectedLink.value);
        if (response != Standings() &&
            response.team!.isNotEmpty &&
            response.point!.isNotEmpty) {
          teams.value = response.team!;
          points.value = response.point!;
        } else {
          showSnackBar('Server error! Please try again.', 2, () {
            isLoading3.value = true;
            loadStandings();
          });
        }
      } catch (e) {
        showSnackBar('Server error! Please try again.', 2, () {
          isLoading3.value = true;
          loadStandings();
        });
      } finally {
        isLoading3.value = false;
      }
    } else {
      showSnackBar('No internet connection please try again!', 2, () {
        isLoading3.value = true;
        loadStandings();
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadStandingLeagues();
  }
}
