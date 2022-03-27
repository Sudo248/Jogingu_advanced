import 'package:hive/hive.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 1)
class NotificationModel {
  @HiveField(0)
  int timeNotifyInMiliseconds;
  @HiveField(1)
  String? note;
  @HiveField(2)
  String timeToRun;

  NotificationModel({
    required this.timeNotifyInMiliseconds,
    required this.timeToRun,
    this.note,
  });
}
