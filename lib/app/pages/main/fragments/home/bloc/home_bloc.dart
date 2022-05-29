import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/base/di.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:jogingu_advanced/domain/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../domain/entities/run.dart';
import '../../../../../../resources/app_assets.dart';

class HomeBloc extends BlocBase {
  final RunRepository runRepo;
  final UserRepository userRepo;
  final TargetPref targetPref = Di.get<TargetPref>();

  HomeBloc({
    required this.runRepo,
    required this.userRepo,
  });

  BehaviorSubject<Status<List<Run>>> runs = BehaviorSubject.seeded(Loading());
  Stream<Status<List<Run>>> get runsStream => runs.stream;
  Sink<Status<List<Run>>> get runsSink => runs.sink;

  late final ImageProvider<Object>? avatar;
  late final String? username;

  Future<bool> deleteRun(dynamic key) async {
    await runRepo.delete(key);
    getAll();
    navigator.back();
    return Future.value(true);
  }

  Future<void> getAll() async {
    runRepo.getAll().listen((listRun) {
      runsSink.add(listRun);
    });
  }

  @override
  void onDispose() async {
    runs.close();
    await runRepo.onDispose();
  }

  @override
  void onInit() async {
    // await runRepo.onInit();
    // mokeData();
    final getName = await userRepo.getName();

    username = getName.data;
    final getAvatarStatus = await userRepo.getAvatarUrl();
    if (getAvatarStatus.data != null) {
      avatar = FileImage(File(getAvatarStatus.data!));
    } else {
      avatar = const AssetImage(AppAssets.avatar);
    }
    getAll();
  }

  void mokeData() {
    for (int i = 0; i < 5; i++) {
      runRepo.add(
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
