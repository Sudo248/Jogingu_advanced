import 'package:hive/hive.dart';
part 'run_model.g.dart';

@HiveType(typeId: 0)
class RunModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  double distance;
  @HiveField(2)
  double avgSpeed;
  @HiveField(3)
  int timeRunning;
  @HiveField(4)
  String? imageUrl;
  @HiveField(5)
  int caloBunred;
  @HiveField(6)
  int timeStartInMiliseconds;
  @HiveField(7)
  int stepCount;
  @HiveField(8)
  String location;

  RunModel({
    required this.name,
    required this.distance,
    required this.avgSpeed,
    required this.timeRunning,
    required this.caloBunred,
    required this.timeStartInMiliseconds,
    required this.stepCount,
    required this.location,
    this.imageUrl,
  });
}
