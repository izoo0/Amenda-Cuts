import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

TimeRange timeRange(
    {required BuildContext context, required Function onRangeCompleted}) {
  return TimeRange(
      fromTitle: Text(
        'From',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      toTitle: Text(
        'To',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      titlePadding: 20,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      activeTextStyle: Theme.of(context).textTheme.bodyMedium,
      backgroundColor: Theme.of(context).cardColor,
      activeBackgroundColor: Theme.of(context).primaryColor,
      firstTime: const TimeOfDay(hour: 8, minute: 00),
      lastTime: const TimeOfDay(hour: 20, minute: 00),
      timeStep: 60,
      timeBlock: 30,
      onRangeCompleted: (range) {
        onRangeCompleted(range);
      });
}
