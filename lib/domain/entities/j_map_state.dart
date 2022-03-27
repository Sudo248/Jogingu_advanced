import 'package:jogingu_advanced/domain/common/run_state.dart';

class JMapState {
  RunState runstate;
  bool isUpdateLocation;
  JMapState({required this.runstate, required this.isUpdateLocation});

  JMapState.init()
      : runstate = RunState.start,
        isUpdateLocation = false;

  JMapState copyWith({RunState? runstate, bool? isUpdateLocation}) {
    return JMapState(
      runstate: runstate ?? this.runstate,
      isUpdateLocation: isUpdateLocation ?? this.isUpdateLocation,
    );
  }
}
