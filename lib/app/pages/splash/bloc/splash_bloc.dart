import 'dart:async';

import 'package:flutter/services.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/base/register.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';


class SplashBloc extends BlocBase {
  @override
  void onDispose() async{
	
  }

  @override
  void onInit() async {

    await register();
    await Future.delayed(const Duration(seconds: 1));
	// await SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: SystemUiOverlay.values,
    // );
    navigator.navigateOff(AppRoutes.main);
  }
}
