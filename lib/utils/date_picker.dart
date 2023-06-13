import 'package:flutter/material.dart';

Future<void> selectDate(BuildContext context, final selectDate) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930, 8),
      lastDate: DateTime(2035));
  if (picked != null) {
    selectDate(picked);
  }
}