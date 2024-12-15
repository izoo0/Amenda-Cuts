import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

EasyDateTimeLinePicker datePicker(
    {required DateTime selectedTime, required Function onDateChange}) {
  return EasyDateTimeLinePicker(
    currentDate: DateTime.now(),
    focusedDate: selectedTime,
    firstDate: DateTime(2024, 3, 18),
    lastDate: DateTime(2090, 3, 18),
    selectionMode: const SelectionMode.autoCenter(),
    timelineOptions:
        const TimelineOptions(height: 60, padding: EdgeInsets.zero),
    onDateChange: (date) {
      onDateChange(date);
    },
  );
}
