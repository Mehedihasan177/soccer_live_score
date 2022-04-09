/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

// ignore_for_file: prefer_const_constructors_in_immutables

import '/consts/consts.dart';
import './gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  DateWidget({
    Key? key,
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: width,
        margin: const EdgeInsets.all(3.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              DateFormat("E", locale).format(date).toUpperCase(), // Month
              style: monthTextStyle!.copyWith(
                fontSize: AppSizes.size14,
                fontWeight: FontWeight.bold,
                color: selectionColor,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(), // Date
                  style: dateTextStyle!.copyWith(
                    color: selectionColor,
                    fontSize: AppSizes.size12,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  DateFormat("MMM", locale)
                      .format(date)
                      .toUpperCase(), // WeekDay
                  style: dayTextStyle!.copyWith(
                    color: selectionColor,
                    fontSize: AppSizes.size12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(date);
        }
      },
    );
  }
}
