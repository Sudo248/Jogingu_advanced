import 'package:jogingu_advanced/data/models/run_model.dart';

import '../../domain/entities/run.dart';

extension RunToRunModel on Run {
  RunModel toRunModel() {
    return RunModel(
      name: name,
      distance: distance,
      avgSpeed: avgSpeed,
      timeRunning: timeRunning,
      caloBunred: caloBunred,
      timeStartInMiliseconds: timeStart.millisecondsSinceEpoch,
      stepCount: stepCount,
      location: location,
	  imageUrl: image
    );
  }
}

extension RunModelToRun on RunModel {
  Run toRun() {
    return Run(
      runId: key.toString(),
	  key: key,
      name: name,
      distance: distance,
      avgSpeed: avgSpeed,
      timeRunning: timeRunning,
      caloBunred: caloBunred,
      timeStart: DateTime.fromMillisecondsSinceEpoch(timeStartInMiliseconds),
      stepCount: stepCount,
      location: location,
	  image: imageUrl
    );
  }
}
