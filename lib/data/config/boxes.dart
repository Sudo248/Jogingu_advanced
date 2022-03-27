import 'package:jogingu_advanced/data/models/notification_model.dart';
import 'package:jogingu_advanced/data/models/run_model.dart';
import 'package:jogingu_advanced/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class Boxes {
  static const String user = "user";
  static const String run = "run";
  static const String notification = "notification";

  static Box<UserModel> get getUserBox => Hive.box<UserModel>(user);
  static Box<RunModel> get getRunBox => Hive.box<RunModel>(run);
  static Box<NotificationModel> get getNotificationBox =>
      Hive.box<NotificationModel>(notification);
}
