import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jogingu_advanced/app/components/button.dart';
import 'package:jogingu_advanced/app/service/notification_service.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final notificationService = GetIt.I.get<NotificationService>();

  @override
  Widget build(BuildContext context) {
    print("build AboutPage");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Button(
          child: Text("notification"),
          onPressed: () {
            final time = DateTime.now().add(const Duration(seconds: 10));
            notificationService.scheduleNotificationOnce(
              title: "notification title",
              body: "notification body",
			  scheduledDate: time,
            );
          },
        ),
      ),
    );
  }
}
