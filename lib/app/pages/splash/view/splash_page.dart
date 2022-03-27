import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/splash/bloc/splash_bloc.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_strings.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class SplashPage extends PageBase<SplashBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: AppColors.backgroundColor,
		body: Column(
			crossAxisAlignment: CrossAxisAlignment.center,
			children: const <Widget>[
				Text(AppStrings.appName, style: AppStyles.h3,)
			],
		),
	);
  }
}
