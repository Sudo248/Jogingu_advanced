import 'package:jogingu_advanced/data/config/boxes.dart';
import 'package:jogingu_advanced/data/models/notification_model.dart';
import 'package:jogingu_advanced/data/models/run_model.dart';
import 'package:jogingu_advanced/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RunModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(NotificationModelAdapter());
  
}
