import 'dart:async';

import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class TargetBloc extends BlocBase {
  BehaviorSubject<bool> isUpdate = BehaviorSubject.seeded(false);
  Stream<bool> get isUpdateStream => isUpdate.stream;
  Sink<bool> get isUpdateSink => isUpdate.sink;

  @override
  void onDispose() {
    // TODO: implement onDispose
  }

  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      isUpdateSink.add(true);
    });
  }
}
