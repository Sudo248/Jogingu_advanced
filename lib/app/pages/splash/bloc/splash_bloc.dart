import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/base/di.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:jogingu_advanced/app/service/text_to_speech_service.dart';
import 'package:jogingu_advanced/data/config/setup_database.dart';
import 'package:jogingu_advanced/resources/app_strings.dart';

class SplashBloc extends BlocBase {
  bool finishAnimation = false;

  @override
  void onDispose() async {}

  @override
  void onInit() async {
    await setupDatabase();
    await Future.delayed(const Duration(seconds: 1));
    Di.get<TextToSpeechService>().speak(AppStrings.wellcome);
    await Future.delayed(const Duration(seconds: 1));
    // await SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: SystemUiOverlay.values,
    // );
    navigator.navigateOff(AppRoutes.main);
    // navigator.navigateTo(AppRoutes.about);
  }

  double getAnimationButtom() {
    return finishAnimation ? globalData.height * 0.5 : globalData.height * 0.4;
  }

  double getOpacity() {
    return finishAnimation ? 1.0 : 0.0;
  }
}
