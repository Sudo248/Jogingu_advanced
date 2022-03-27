import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_assets.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class AppBarRegular extends StatelessWidget {
  final String title;
  final VoidCallback onClickLogo;
  const AppBarRegular(
      {Key? key, required this.title, required this.onClickLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      backgroundColor: AppColors.primaryColor,
      title: Text(
        title,
        style: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [
        ElevatedButton(
          onPressed: onClickLogo,
          child: Image.asset(AppAssets.logo_rouned),
        )
      ],
    );
  }
}

class AppBarWithBackground extends StatelessWidget {
  final String title;
  const AppBarWithBackground({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: key,
	  title: Text(
        title,
        style: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
