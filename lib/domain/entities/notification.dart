import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String notificationId;
  final DateTime timeNotify;
  final String? note;
  final String? timeToRun;

  const Notification(
      {required this.notificationId,
      required this.timeNotify,
      this.note,
      this.timeToRun});

  @override
  List<Object?> get props => [notificationId, timeNotify, note, timeToRun];
}
