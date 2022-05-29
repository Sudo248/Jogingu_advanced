import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/components/button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:jogingu_advanced/app/base/di.dart';
import 'package:jogingu_advanced/app/service/notification_service.dart';
import 'package:jogingu_advanced/resources/app_assets.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_strings.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final notificationService = Di.get<NotificationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          "About",
          style: AppStyles.h5.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          AppAssets.logo,
                        ),
                      )),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          AppStrings.appName,
                          textAlign: TextAlign.center,
                          style: AppStyles.h5.copyWith(
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          AppStrings.aboutJogingu,
                          maxLines: 8,
                          style: AppStyles.h5.copyWith(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 8.0, right: 8.0, bottom: 45.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.trainSmarter,
                    textAlign: TextAlign.center,
                    style: AppStyles.h5.copyWith(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                              text: AppStrings.trackAnalyse,
                              style: AppStyles.h5.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.trackAnalyseContent,
                                  style: AppStyles.h5.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                              text: AppStrings.newRoutes,
                              style: AppStyles.h5.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.newRoutesContent,
                                  style: AppStyles.h5.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: RichText(
                          text: TextSpan(
                              text: AppStrings.challageComplete,
                              style: AppStyles.h5.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.challageCompleteContent,
                                  style: AppStyles.h5.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 12.0, left: 8.0, right: 8.0, bottom: 45.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Developer",
                      textAlign: TextAlign.center,
                      style: AppStyles.h5.copyWith(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Name: ",
                      style: AppStyles.h5.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.developer,
                          style: AppStyles.h5.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Facebook: ",
                      style: AppStyles.h5.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        TextSpan(
                          text: "duonglh.248",
                          style: AppStyles.h5.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => launchUrlString(AppStrings.linkFace),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Github: ",
                      style: AppStyles.h5.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        TextSpan(
                          text: "Sudo248",
                          style: AppStyles.h5.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => launchUrlString(AppStrings.linkGithub),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Description",
                      style: AppStyles.h5.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.description,
                          style: AppStyles.h5.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    child: GestureDetector(
                      onTap: () => launchUrlString(
                        AppStrings.linkBuyMeCoffee,
                      ),
                      child: Image.asset(
                        AppAssets.cup_coffee,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                AppStrings.version,
				textAlign: TextAlign.center,
                style: AppStyles.h5.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
