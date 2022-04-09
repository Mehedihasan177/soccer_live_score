// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consts/app_colors.dart';
import '../../services/custom_ad/custom_ad.dart';

class PredictionDetailsScreen extends StatefulWidget {
  final arguments;
  const PredictionDetailsScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _PredictionDetailsScreenState createState() =>
      _PredictionDetailsScreenState();
}

class _PredictionDetailsScreenState extends State<PredictionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: widget.arguments['title'].length > 25
            ? SizedBox(
                height: 20,
                child: Marquee(
                  text: widget.arguments['title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              )
            : Text(widget.arguments['title']),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Html(
          data: widget.arguments['prediction_details'] ?? ' ',
          style: {
            "*": Style(
              color: Colors.white,
              textAlign: TextAlign.justify,
              fontWeight: FontWeight.normal,
            ),
          },
          onLinkTap: (url, context, attributes, element) => {
            launch(url!),
          },
        ),
      ),
      bottomNavigationBar: const CustomBannerAd(),
    );
  }
}
