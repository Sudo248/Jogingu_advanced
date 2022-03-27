import 'dart:ui';

import 'package:equatable/equatable.dart';

class Run extends Equatable {
  final String runId;
  final String name;
  final double distance;
  final double avgSpeed;
  final int timeRunning;
  final String? image;
  final int caloBunred;
  final DateTime timeStart;
  final int stepCount;
  final String location;

  const Run(
      {required this.runId,
      required this.name,
      required this.distance,
      required this.avgSpeed,
      required this.timeRunning,
      this.image,
      required this.caloBunred,
      required this.timeStart,
      required this.stepCount,
      required this.location});

  @override
  List<Object?> get props => [
        runId,
        name,
        distance,
        avgSpeed,
        timeRunning,
        image,
        caloBunred,
        timeStart,
        stepCount,
        location,
      ];
}
