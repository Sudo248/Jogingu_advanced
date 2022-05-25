import 'package:jogingu_advanced/app/base/dependency.dart';
import 'package:jogingu_advanced/app/pages/run/bloc/run_bloc.dart';
import 'package:jogingu_advanced/data/services/location_service.dart';
import 'package:jogingu_advanced/data/services/step_counter_service.dart';
import 'package:jogingu_advanced/data/services/timer_service.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:jogingu_advanced/domain/repositories/user_repository.dart';

import '../base/di.dart';

class RunDependency implements Dependency {
  @override
  void dependencies() {
    Di.put<RunBloc>(
      () => RunBloc(
        locationService: LocationService(),
        timerService: TimerService(),
        stepCounterService: StepCounterService(),
        runRepo: Di.get<RunRepository>(),
        userRepo: Di.get<UserRepository>(),
      ),
    );
  }
}
