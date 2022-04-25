import 'package:jogingu_advanced/data/models/notification_model.dart';
import 'package:jogingu_advanced/data/models/run_model.dart';
import 'package:jogingu_advanced/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  final String user = "user";
  final String run = "run";
  final String notification = "notification";

  Boxes._internal();

  static Boxes? instance;

  static Boxes get I {
    instance ??= Boxes._internal();
    return instance!;
  }

  Future<Box<UserModel>> get userBox => Hive.openBox<UserModel>(user);
  Future<Box<RunModel>> get runBox => Hive.openBox<RunModel>(run);
  Future<Box<NotificationModel>> get notificationBox =>
      Hive.openBox<NotificationModel>(notification);
}
