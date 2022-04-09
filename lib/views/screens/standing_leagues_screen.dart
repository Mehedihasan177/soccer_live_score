import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/custom_ad/custom_ad.dart';
import '/consts/consts.dart';
import '/controllers/standing_controller.dart';
import '/models/standing_leagues.dart';
import '/views/screens/standings_screen.dart';

class StandingLeaguesScreen extends StatefulWidget {
  const StandingLeaguesScreen({Key? key}) : super(key: key);

  @override
  _StandingLeaguesScreenState createState() => _StandingLeaguesScreenState();
}

class _StandingLeaguesScreenState extends State<StandingLeaguesScreen> {
  StandingController standingController = Get.put(StandingController());
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.blue,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
          child: Obx(() {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  padding: const EdgeInsets.only(top: 2, left: 0, right: 0),
                  child: RefreshIndicator(
                    onRefresh: () {
                      controller.clear();
                      standingController.onSearchTextChanged('');
                      return standingController.loadStandingLeagues();
                    },
                    child: !standingController.isLoading.value
                        ? standingController.leagues.isEmpty
                            ? const Center(
                                child: Text(
                                  'No Leagues found!',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : standingController.query.value.isNotEmpty
                                ? standingController.searchResult.isNotEmpty
                                    ? RefreshIndicator(
                                        onRefresh: () => standingController
                                            .loadStandingLeagues(),
                                        child: LeaguesWidget(
                                          data: standingController.searchResult,
                                          standingController:
                                              standingController,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          'No Leagues found!',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                : LeaguesWidget(
                                    data: standingController.leagues,
                                    standingController: standingController,
                                  )
                        : const Center(),
                  ),
                ),
                if (!standingController.isLoading.value)
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(
                      top: 5,
                      bottom: 4,
                      left: 4,
                      right: 4,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.background2,
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 8.0,
                      ),
                      leading: const Icon(
                        Icons.search,
                        color: AppColors.text,
                      ),
                      title: TextField(
                        style: const TextStyle(
                          color: AppColors.text,
                        ),
                        controller: controller,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: AppColors.text,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: standingController.onSearchTextChanged,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 18,
                        ),
                        onPressed: () {
                          controller.clear();
                          standingController.onSearchTextChanged('');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: const CustomBannerAd(),
    );
  }
}

// ignore: must_be_immutable
class LeaguesWidget extends StatelessWidget {
  LeaguesWidget({
    Key? key,
    required this.data,
    required this.standingController,
  }) : super(key: key);

  final List<League> data;
  StandingController standingController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: ((context, index) {
        return Container(
          height: 5,
          // color: Colors.black.withOpacity(.05),
        );
      }),
      itemCount: data.length,
      itemBuilder: (context, i) {
        var standingLeague = data[i];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black.withOpacity(.05)),
            borderRadius: BorderRadius.circular(4),
            color: AppColors.background2,
          ),
          child: ListTile(
            dense: true,
            leading: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.background.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              width: AppSizes.newSize(3),
              height: AppSizes.newSize(3),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontSize: AppSizes.size12,
                  color: AppColors.text,
                ),
              ),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                standingLeague.name ?? '',
                style: TextStyle(
                  fontSize: AppSizes.size14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.text,
              size: AppSizes.size12,
            ),
            onTap: () {
              var arguments = {
                'title': standingLeague.name,
                'link': standingLeague.link,
              };
              CustomInterstitialAd.show(callback: () {
                Get.to(() => StandingsScreen(arguments));
              });
            },
          ),
        );
      },
    );
  }
}
