// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:big_soccer/views/screens/prediction_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/custom_ad/custom_ad.dart';
import '/consts/consts.dart';
import '/controllers/prediction_controller.dart';
import '/models/prediction.dart';
import '/views/widgets/indicator.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final CarouselController _controller = CarouselController();
  PredictionController predictionController = Get.put(PredictionController());
  int touchedIndex = -1;
  List pp = [1, 2, 3, 4, 5];
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => predictionController.loadPrediction(),
      child: Obx(() {
        return !predictionController.isLoading.value
            ? (predictionController.prediction.value.data?.length ?? 0) > 0
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: AppSizes.newSize(75),
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          items: predictionController.prediction.value.data!
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    //e.prediction_details
                                    var arguments = {
                                      'prediction_details':
                                          e.prediction_details,
                                      'title': e.teamOneName! +
                                          " VS " +
                                          e.teamTwoName! +
                                          " " +
                                          "Prediction Details"
                                    };

                                    CustomInterstitialAd.show(callback: () {
                                      Get.to(() =>
                                          PredictionDetailsScreen(arguments));
                                    });
                                  },
                                  child: Card(
                                    color: AppColors.background2,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.background2,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            height: AppSizes.newSize(20),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 15, bottom: 10),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Text(
                                                    e.matchTitle ?? '',
                                                    style: TextStyle(
                                                      fontSize: AppSizes.size15,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl:
                                                                    e.teamOneImage ??
                                                                        '',
                                                                height: AppSizes
                                                                    .newSize(5),
                                                                width: AppSizes
                                                                    .newSize(5),
                                                                errorWidget:
                                                                    (context,
                                                                        url,
                                                                        error) {
                                                                  return Image.asset(
                                                                      AppAssets
                                                                          .team);
                                                                },
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      SizedBox(
                                                                    height: 2 *
                                                                        screenSize /
                                                                        100,
                                                                    width: 2 *
                                                                        screenSize /
                                                                        100,
                                                                    child: Image.asset(
                                                                        AppAssets
                                                                            .loading),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Container(
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                child: Text(
                                                                  e.teamOneName ??
                                                                      '',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        AppSizes
                                                                            .size12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            'VS'.tr,
                                                            style: TextStyle(
                                                              fontSize: AppSizes
                                                                  .size16,
                                                              color: Colors.red,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl:
                                                                    e.teamTwoImage ??
                                                                        '',
                                                                height: AppSizes
                                                                    .newSize(5),
                                                                width: AppSizes
                                                                    .newSize(5),
                                                                errorWidget:
                                                                    (context,
                                                                        url,
                                                                        error) {
                                                                  return Image.asset(
                                                                      AppAssets
                                                                          .team);
                                                                },
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      SizedBox(
                                                                    height: 2 *
                                                                        screenSize /
                                                                        100,
                                                                    width: 2 *
                                                                        screenSize /
                                                                        100,
                                                                    child: Image.asset(
                                                                        AppAssets
                                                                            .loading),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Container(
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                child: Text(
                                                                  e.teamTwoName ??
                                                                      '',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        AppSizes
                                                                            .size12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                'Tab For Details Prediction'.tr,
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AppSizes.size16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: AppSizes.newSize(35),
                                            child: PieChart(
                                              PieChartData(
                                                // pieTouchData: PieTouchData(
                                                //     touchCallback:
                                                //         (PieTouchResponse
                                                //             event) {
                                                //   setState(() {
                                                //     if (event.touchedSection ==
                                                //         null) {
                                                //       touchedIndex = -1;
                                                //       return;
                                                //     }
                                                //     touchedIndex = event
                                                //         .touchedSection!
                                                //         .touchedSectionIndex;
                                                //   });
                                                // }),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 40,
                                                sections: showingSections(e),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Indicator(
                                                  color: Colors.green.shade600,
                                                  text: e.teamOneName ?? '',
                                                  isSquare: true,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Indicator(
                                                  color:
                                                      const Color(0xff845bef),
                                                  text: e.teamTwoName ?? '',
                                                  isSquare: true,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Indicator(
                                                  color: Color(0xfff8b250),
                                                  text: 'Draw',
                                                  isSquare: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: predictionController.prediction.value.data!
                              .asMap()
                              .entries
                              .map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.red
                                          : Colors.white)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Container(
                      color: AppColors.blue,
                      padding: const EdgeInsets.all(20),
                      height: screenSize - AppSizes.newSize(25),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'No prediction available.'.tr,
                          style: TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.size16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
      }),
    );
  }

  List<PieChartSectionData> showingSections(Data e) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 80.0 : 70.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green.shade600,
            value: double.parse((e.teamOneWinningPrediction ?? 0).toString()),
            title: (e.teamOneWinningPrediction ?? 0).toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse((e.matchTiePrediction ?? 0).toString()),
            title: (e.matchTiePrediction ?? 0).toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: double.parse((e.matchTiePrediction ?? 0).toString()),
            title: (e.teamTwoWinningPrediction ?? 0).toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
