import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../resources/app_colors.dart';

Future<TimeOfDay?> showJoginguTimePicker(BuildContext context) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
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
    },
  );
}

Future<T?> showJoginguConfirmDialog<T>(
  BuildContext context, {
  Widget? title,
  Widget? content,
  VoidCallback? onNegative,
  VoidCallback? onPositive,
  VoidCallback? onCancel,
}) async {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: title,
        content: content,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPositive,
            child: const Text(
              "Yes",
            ),
          ),
          TextButton(
            child: const Text(
              'No',
            ),
            onPressed: onNegative,
          ),
          onCancel != null ? TextButton(
            onPressed: onCancel,
            child: const Text(
              "Cancel",
            ),
          ) : const SizedBox.shrink()
        ],
      );
    },
  );
}
