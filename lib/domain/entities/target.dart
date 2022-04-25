import 'package:equatable/equatable.dart';

class Target extends Equatable {
  int distance;
  int calo;
  String? place;
  int recursive;
  DateTime? timeStart;
  int notifyBefore;

  Target({
    this.distance = 0,
    this.calo = 0,
    this.place,
    this.recursive = 0,
    this.timeStart,
    this.notifyBefore = 10,
  });

  @override
  List<Object?> get props => [
        distance,
        calo,
        place,
        recursive,
        timeStart,
        notifyBefore,
      ];
}
