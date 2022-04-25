import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Text("About us"),
      ),
    );
  }
}
