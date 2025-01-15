import 'package:flutter/material.dart';

Radio radioListTile(
    {required String value,
    required String groupValue,
    required Function onChange}) {
  return Radio(
      value: value,
      groupValue: groupValue,
      onChanged: (val) {
        onChange(val);
      });
}
