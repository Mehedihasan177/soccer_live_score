import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/football_news.dart';
import '../../services/custom_ad/custom_ad.dart';
import '/consts/consts.dart';
import '/controllers/news_controller.dart';
import '/views/screens/news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.blue,
        child: Obx(() {
          return !newsController.isLoading.value
              ? RefreshIndicator(
                  onRefresh: () => newsController.loadFootballNews(),
                  child: ListView.builder(
                      itemCount: newsController.news!.length,
                      itemBuilder: (context, index) {
                        News newsItem = newsController.news![index];
                        return newsItemWidget(context, newsItem);
                      }),
                )
              : Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(AppAssets.loading),
                  ),
                );
        }),
      ),
    );
  }
}

Widget newsItemWidget(context, News newsItem) {
  return InkWell(
    onTap: () {
      var arguments = {
        'newsTitle': newsItem.title ?? '',
        'newsImage': newsItem.image ?? '',
        'newsURL': newsItem.link ?? '',
      };

      CustomInterstitialAd.show(callback: () {
        Get.to(() => NewsDatailsScreen(arguments));
      });
    },
    child: Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.background2,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: AppSizes.newSize(9.0),
                        child: Text(
                          newsItem.title ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.size14,
                            color: AppColors.text,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 4,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: AppSizes.newSize(3.2),
                        child: const Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppColors.text,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: newsItem.image ?? '',
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(AppAssets.loading),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fill,
                      height: AppSizes.newSize(13),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
