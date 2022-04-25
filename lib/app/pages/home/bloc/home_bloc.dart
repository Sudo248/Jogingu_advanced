import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/run.dart';

class HomeBloc extends BlocBase {
  final RunRepository repository;
  HomeBloc({required this.repository});

  BehaviorSubject<Status<List<Run>>> runs = BehaviorSubject.seeded(Loading());
  Stream<Status<List<Run>>> get runsStream => runs.stream;
  Sink<Status<List<Run>>> get runsSink => runs.sink;

  Future<bool> deleteRun(dynamic key) async {
    await repository.delete(key);
    getAll();
    navigator.back();
    return Future.value(true);
  }

  Future<void> getAll() async {
    repository.getAll().listen((listRun) {
      runsSink.add(listRun);
    });
  }

  @override
  void onDispose() async {
    await repository.onDispose();
  }

  @override
  void onInit() async {
    await repository.onInit();
    // mokeData();
    getAll();
  }

  void mokeData() {
    for (int i = 0; i < 5; i++) {
      repository.add(
        Run(
          runId: "",
          key: -1,
          name: "test $i",
          distance: 100,
          avgSpeed: 123,
          timeRunning: 1234,
          caloBunred: 0,
          timeStart: DateTime.now(),
          stepCount: 25,
          location: "Hanoi ",
          image: null,
        ),
      );
    }
  }
}
