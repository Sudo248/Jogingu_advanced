import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogingu_advanced/app/pages/splash/bloc/splash_bloc.dart';
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
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Text(
          AppStrings.appName,
          style: AppStyles.h3,
        ),
      ),
    );
  }
}

// class SplashPage extends PageBase<SplashBloc>{
//   @override
//   Widget build(BuildContext context) {
//      print("build SplashPage");
//     return const Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: Center(
//         child: Text(
//           AppStrings.appName,
//           style: AppStyles.h3,
//         ),
//       ),
//     );
//   }
	
// }
