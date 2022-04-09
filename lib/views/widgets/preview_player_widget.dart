// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '/consts/consts.dart';

class PreviewPlayerWidget extends StatelessWidget {
  const PreviewPlayerWidget({
    Key? key,
    required this.e,
  }) : super(key: key);

  final e;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomRight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/jersey.png"),
                fit: BoxFit.cover,
                invertColors: true,
              ),
            ),
            width: AppSizes.newSize(5.4),
            height: AppSizes.newSize(5.4),
            child: Container(
              width: AppSizes.newSize(5.4),
              height: AppSizes.newSize(5.4),
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                e['pJarcyNo'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.size12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e['pName'],
                  style: TextStyle(
                    fontSize: AppSizes.size14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  e['pStatus'],
                  style: TextStyle(
                    fontSize: AppSizes.size13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
