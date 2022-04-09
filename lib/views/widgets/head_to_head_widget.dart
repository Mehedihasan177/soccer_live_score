import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/consts/consts.dart';

class HeadToHeadWidget extends StatelessWidget {
  const HeadToHeadWidget({
    Key? key,
    this.e,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final e;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.newSize(18),
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.league ?? '',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: AppSizes.size12,
                  ),
                ),
                Text(
                  e.gameDate,
                  style: TextStyle(
                    fontSize: AppSizes.size12,
                    color: AppColors.text.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: AppColors.border,
            height: 0.2,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: e.t1Img,
                            imageBuilder: (context, imageProvider) => Container(
                              width: AppSizes.newSize(3.5),
                              height: AppSizes.newSize(3.5),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 1.5,
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: AppSizes.newSize(3.2),
                              padding: const EdgeInsets.all(5),
                              height: AppSizes.newSize(3.2),
                              child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primaryColor)),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              AppAssets.team,
                              width: AppSizes.newSize(3.2),
                              height: AppSizes.newSize(3.2),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                e.team1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppSizes.size13,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e.score,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.size16,
                              color: AppColors.text,
                            ),
                          ),
                          const Text(
                            'Full Fime',
                            style: TextStyle(
                              color: AppColors.text,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: e.t2Img,
                          imageBuilder: (context, imageProvider) => Container(
                            width: AppSizes.newSize(3.5),
                            height: AppSizes.newSize(3.5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.grey[400]!,
                                width: 1.5,
                              ),
                              //shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: AppSizes.newSize(3.2),
                            padding: const EdgeInsets.all(5),
                            height: AppSizes.newSize(3.2),
                            child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor)),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppAssets.team,
                            width: AppSizes.newSize(3.2),
                            height: AppSizes.newSize(3.2),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Text(
                              e.team2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppSizes.size13,
                                color: AppColors.text,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
