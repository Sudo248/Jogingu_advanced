import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogingu_advanced/app/pages/splash/bloc/splash_bloc.dart';
import 'package:jogingu_advanced/resources/app_assets.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_strings.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashBloc bloc = SplashBloc();
  @override
  void initState() {
    bloc.onInit();
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => setState(
        () {
          bloc.finishAnimation = true;
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.onDispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: bloc.globalData.height * 0.4,
            child: Text(
              AppStrings.appName,
              style: AppStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: bloc.getAnimationButtom(),
            child: Image.asset(AppAssets.logo_splash),
            duration: const Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}
