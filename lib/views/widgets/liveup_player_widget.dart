// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/consts/consts.dart';
import '/models/match_line_up.dart';

class LineUpPlayerWidget extends StatelessWidget {
  const LineUpPlayerWidget({
    Key? key,
    required this.lineUp,
  }) : super(key: key);

  final PlayerList lineUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: lineUp.iconT1Start == ''
          ? BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5, color: AppColors.border),
              ),
            )
          : const BoxDecoration(),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
        title: Row(
          children: [
            if (lineUp.iconT1Start != '' && lineUp.iconT1Start != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: AppConsts.BASE_URL +
                      '/public/football/icon/' +
                      lineUp.iconT1Start!,
                  height: 20,
                  width: 20,
                  placeholder: (context, url) => Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.all(5),
                    child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor)),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/default-team.png',
                  ),
                ),
              ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/football-player.png',
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                '${lineUp.t1pName} (${lineUp.t1pNo?.replaceAll(' ', '')})',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text,
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (lineUp.endIcon!.goal!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  AppConsts.BASE_URL +
                      '/public/football/icon/' +
                      lineUp.endIcon!.goal!,
                  height: 20,
                  width: 20,
                ),
              ),
            const SizedBox(width: 5),
            if (lineUp.endIcon!.redCrd!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  AppConsts.BASE_URL +
                      '/public/football/icon/' +
                      lineUp.endIcon!.redCrd!,
                  height: 20,
                  width: 20,
                ),
              ),
            const SizedBox(width: 5),
            if (lineUp.endIcon!.yelloCrd!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  AppConsts.BASE_URL +
                      '/public/football/icon/' +
                      lineUp.endIcon!.yelloCrd!,
                  height: 20,
                  width: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
