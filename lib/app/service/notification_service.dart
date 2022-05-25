import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:jogingu_advanced/domain/common/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  NotificationService.initialize({bool initScheduled = false}) {
    initNotification(initScheduled: initScheduled);
  }

  final notification = FlutterLocalNotificationsPlugin();

  final onNotifications = BehaviorSubject<String?>();
  Stream<String?> get onNotificationStream => onNotifications.stream;
  Sink<String?> get onNotificationSink => onNotifications.sink;

  Future<void> initNotification({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    // tap notification to open app
    final details = await notification.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotificationSink.add(details.payload);
    }

    await notification.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotificationSink.add(payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        Constants.androidChannelId,
        Constants.androidChannelName,
        channelDescription: Constants.androidChannelDescription,
        icon: Constants.androidNotificationIcon,
        importance: Importance.max,
		styleInformation: BigTextStyleInformation(''),
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    notification.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }

  Future<void> scheduleNotificationOnce({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    // tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);
    // DateTimeComponents? matchDateTimeComponents;

    // if (mode == ScheduleNotificationMode.DAILY) {
    //   tzScheduledDate = _scheduleDaily(Time(
    //     scheduledDate.hour,
    //     scheduledDate.minute,
    //     scheduledDate.second,
    //   ));
    //   matchDateTimeComponents = DateTimeComponents.time;
    // } else if (mode == ScheduleNotificationMode.WEEKLY) {
    //   tzScheduledDate = _scheduleWeekly(time, days: days);
    //   matchDateTimeComponents = DateTimeComponents.dayOfWeekAndTime;
    // }
    notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleNotificationDaily({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required Time time,
  }) async {
    notification.zonedSchedule(
      id,
      title,
      body,
      _scheduleDaily(time),
      await _notificationDetails(),
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleNotificationWeekly({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required Time time,
    required List<int> days,
  }) async {
    notification.zonedSchedule(
      id,
      title,
      body,
      _scheduleWeekly(time, days: days),
      await _notificationDetails(),
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);
    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelAllNotification() => notification.cancelAll();

  Future<void> cancelNotification({required int id}) => notification.cancel(id);
}
