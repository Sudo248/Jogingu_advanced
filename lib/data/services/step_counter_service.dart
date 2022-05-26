import 'dart:async';
import 'dart:math';

import 'package:pedometer/pedometer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../../domain/common/logger.dart';

class StepCounterService {
  final BehaviorSubject<int> stepCounter = BehaviorSubject.seeded(0);
  Stream<int> get stepCounterStream => stepCounter.stream;
  Sink<int> get stepCounterSink => stepCounter.sink;
  late final StreamSubscription pedometerStreamSubscription;
  late final StreamSubscription? sensorStreamSubscription;
//   final BehaviorSubject<RunStatus> runStatus =
//       BehaviorSubject.seeded(RunStatus.init);
//   Stream<RunStatus> get runStatusStream => runStatus.stream;
//   Sink<RunStatus> get runStatusSink => runStatus.sink;

  bool isRunning = false;

  double magnitudePrevious = 6.9;

  int? stepPrevious;

  void subscribeStepCounterService() {
    pedometerStreamSubscription =
        Pedometer.stepCountStream.listen(onPedestrianStepCount);
    pedometerStreamSubscription.onError((error) {
      Logger.error(message: "pedometer Stream Subscription: $error");
      pedometerStreamSubscription.cancel();
      sensorStreamSubscription =
          accelerometerEvents.listen(onSenSorStepCounter);
    });
    Logger.success(message: "subscribe Step Counter Service");

    // Pedometer.pedestrianStatusStream
    //     .listen(onPedestrianStatusChanged)
    //     .onError((_) => {});
  }

  void start() {
    isRunning = true;
  }

  void pause() {
    isRunning = false;
  }

  void resume() {
    isRunning = true;
  }

  void cancel() {
    pedometerStreamSubscription.cancel();
    sensorStreamSubscription?.cancel();
  }

  void onPedestrianStepCount(StepCount event) async {
    /// Handle step count changed
    Logger.debug(message: "on Pedestrian Step Count: ${event.steps}");
    if (isRunning) {
      int steps = event.steps;
      stepPrevious ??= steps;
      stepCounterSink.add(steps - stepPrevious!);
      Logger.success(message: "time: ${event.timeStamp}, steps: $steps");
    } else {
      stepPrevious = event.steps;
    }
  }

//   void onPedestrianStatusChanged(PedestrianStatus event) async {
//     /// Handle status changed
//     final status = event.status;
//     Logger.success(message: "time: ${event.timeStamp}, status: $status");
//     switch (status) {
//       case 'walking':
//         if (isRunning) {
//           runStatusSink.add(RunStatus.running);
//         } else {
//           runStatusSink.add(RunStatus.runningWithoutService);
//         }
//         break;
//       case 'stopped':
//         runStatusSink.add(RunStatus.stoped);
//         break;
//       default:
//         runStatusSink.add(RunStatus.unknown);
//     }
//   }

  Future<void> onSenSorStepCounter(AccelerometerEvent event) async {
    if (isRunning) {
      double y = event.y; //- 9.8;
      final magnitude = sqrt(event.x * event.x + y * y + event.z * event.z);
      final magnitudeDelta = magnitude - magnitudePrevious;
      magnitudePrevious = magnitude;
    //   Logger.debug(message: "magnitudeDelta: $magnitudeDelta");
      if (magnitudeDelta > 6.9) {
        // Logger.success(message: "Sensor Counter up");
        // Logger.debug(message: "magnitudeDelta: $magnitudeDelta");
        stepCounterSink.add(stepCounter.value + 1);
      }
    }
  }

//   void onSensorStatusChanged() async {}
}