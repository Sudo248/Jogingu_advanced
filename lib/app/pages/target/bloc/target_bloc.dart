import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/utils/util.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/target.dart';

class TargetBloc extends BlocBase {
  final ValueNotifier<String> distance = ValueNotifier(""),
      calo = ValueNotifier(""),
      place = ValueNotifier(""),
      recursive = ValueNotifier(""),
      timeStart = ValueNotifier(""),
      notifyBefore = ValueNotifier("");

  late Target target;

  final TargetPref pref;

  TargetBloc({required this.pref});

  @override
  void onDispose() {
    // TODO: implement onDispose
  }

  Future<void> updateUiTarget() async {
    target = await pref.getTarget();
    distance.value = "${target.distance} km";
    calo.value = "${target.calo} calos";
    place.value = target.place!;
    recursive.value = "${target.recursive} times";
    timeStart.value = formatTimeOfDay(target.timeStart);
    notifyBefore.value = "${target.notifyBefore}";
  }

  @override
  void onInit() async {
    updateUiTarget();
  }

  void navigateToPage(String route) async {
    await navigator.navigateTo(route);
    updateUiTarget();
  }
}
