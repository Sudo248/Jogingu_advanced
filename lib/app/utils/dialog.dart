import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../resources/app_colors.dart';

Future<DateTime?> showJoginguDatePicker(BuildContext context, {DateTime? initialDate}) {
  return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              onPrimary: Colors.white, // selected text color
              onSurface: AppColors.primaryColor, // default text color
              primary: AppColors.primaryColor, // circle color
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: AppStyles.h6.copyWith(fontWeight: FontWeight.normal),
                primary: Colors.white, // color of button's letters
                backgroundColor: AppColors.primaryColor, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          child: child!,
        );
      });
}

Future<TimeOfDay?> showJoginguTimePicker(BuildContext context, {TimeOfDay? initialTime, bool alwaysUse24HourFormat = false}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: alwaysUse24HourFormat),
        child: Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              onPrimary: Colors.white, // selected text color
              onSurface: AppColors.primaryColor, // default text color
              primary: AppColors.primaryColor, // circle color
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: AppStyles.h6.copyWith(fontWeight: FontWeight.normal),
                primary: Colors.white, // color of button's letters
                backgroundColor: AppColors.primaryColor, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          child: child!,
        ),
      );
    },
  );
}

Future<T?> showJoginguConfirmDialog<T>(
  BuildContext context, {
  Widget? title,
  Widget? content,
  VoidCallback? onNegative,
  VoidCallback? onPositive,
}) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: title,
        content: content,
        actionsAlignment: MainAxisAlignment.spaceAround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
              onPositive?.call();
            },
            child: const Text(
              "Yes",
            ),
          ),
          TextButton(
            child: const Text(
              'No',
            ),
            onPressed: () {
              Navigator.pop(context, false);
              onNegative?.call();
            },
          ),
        ],
      );
    },
  );
}

Future<T?> showJoginguAlertDialog<T>(
  BuildContext context, {
  Widget? title,
  Widget? content,
  VoidCallback? onClick,
}) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: title,
        content: content,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onClick?.call();
            },
            child: const Text(
              "OK",
            ),
          ),
        ],
      );
    },
  );
}
