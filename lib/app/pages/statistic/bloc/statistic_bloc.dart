import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/utils/chart.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

import '../../../../domain/entities/run.dart';

class StatisticBloc extends BlocBase {
  late List<Run?> data;
  double? maxY;

  final RunRepository repo;

  StatisticBloc({required this.repo});

  final ValueNotifier<String> titleNotifer = ValueNotifier("Today");
  final ValueNotifier<int> totalStepsNotifer = ValueNotifier(0);
  final ValueNotifier<double> totalCaloriesNotifer = ValueNotifier(0),
      totalTimeNotifer = ValueNotifier(0),
      totalDistancesNotifer = ValueNotifier(0);

  List<Run?>? runsThisDay;
  List<Run?>? runsThisWeek;
  List<Run?>? runsThisMonth;

  int totalSteps = 0;
  double totalCalories = 0, totalTime = 0, totalDistance = 0;

//   StreamController<TypeChart> typeChartSC = StreamController();

  late final BehaviorSubject<TypeChart> typeChartSC;

  @override
  void onDispose() {
    data.clear();
    typeChartSC.close();
  }

  @override
  void onInit() {
    // // TODO: implement onInit
    // mokeData(24);
    // typeChartSC.add(TypeChart.day);
    typeChartSC = BehaviorSubject.seeded(TypeChart.day);
    data = List.generate(
      24,
      (index) => Run(
        runId: "1",
        key: 1,
        name: "Run 1",
        distance: 0.0,
        avgSpeed: 1,
        timeRunning: 1,
        caloBunred: 1,
        timeStart: DateTime.now(),
        stepCount: 10,
        location: "Hanoi",
      ),
    );

    repo.getRunsThisDay().listen((event) {
      print("init get run this day");
      // if (event.isSuccess) {
        runsThisDay = event.data;
        showCharInDay();
      // }
    });
	
  }

  void onDayClick() {
    if (runsThisDay != null) {
      showCharInDay();
    }
    // mokeData(24);
    // typeChartSC.add(TypeChart.day);
    // titleNotifer.value = "Today";
    // totalStepsNotifer.value = 300;
    // totalCaloriesNotifer.value = 525.5;
    // totalDistancesNotifer.value = 5;
    // totalTimeNotifer.value = 3;
  }

  void onWeekClick() {
    if (runsThisWeek == null) {
      repo.getRunsThisWeek().listen((event) {
        if (event.isSuccess) {
          runsThisWeek = event.data;
          while (runsThisWeek!.length < 7) {
            runsThisWeek!.add(null);
          }
          showChartInWeek();
        }
      });
    } else {
      showChartInWeek();
    }
    // mokeData(7);
    // typeChartSC.add(TypeChart.week);
    // titleNotifer.value = "This week";
    // totalStepsNotifer.value = 500;
    // totalCaloriesNotifer.value = 3225.5;
    // totalDistancesNotifer.value = 7;
    // totalTimeNotifer.value = 5;
  }

  void onMonthClick() {
    if (runsThisMonth == null) {
      repo.getRunsThisMonth().listen((event) {
        if (event.isSuccess) {
          runsThisMonth = event.data;
          while (runsThisMonth!.length < 7) {
            runsThisMonth!.add(null);
          }
          showChartInMonth();
        }
      });
    } else {
      showChartInMonth();
    }
    // mokeData(30);
    // typeChartSC.add(TypeChart.month);
    // titleNotifer.value = "This month";
    // totalStepsNotifer.value = 10000;
    // totalCaloriesNotifer.value = 53925.5;
    // totalDistancesNotifer.value = 23;
    // totalTimeNotifer.value = 24;
  }

  void showCharInDay() {
    data = runsThisDay!;
    typeChartSC.add(TypeChart.day);
    titleNotifer.value = "Today";
    totalStepsNotifer.value = 0;
    totalCaloriesNotifer.value = 0;
    totalDistancesNotifer.value = 0;
    totalTimeNotifer.value = 0;
    double maxDistance = 0;
    for (var e in data) {
      if (e != null) {
        totalStepsNotifer.value += e.stepCount;
        totalCaloriesNotifer.value += e.caloBunred;
        totalDistancesNotifer.value += e.distance;
        totalTimeNotifer.value += (e.timeRunning / 3600);
        if(maxDistance < e.distance) maxDistance = e.distance;
      }
    }
    maxY = maxDistance+1;
  }

  void showChartInWeek() {
    data = runsThisWeek!;
    typeChartSC.add(TypeChart.week);
    titleNotifer.value = "This week";
    totalStepsNotifer.value = 0;
    totalCaloriesNotifer.value = 0;
    totalDistancesNotifer.value = 0;
    totalTimeNotifer.value = 0;
    double maxDistance = 0;
    for (var e in data) {
      if (e != null) {
        totalStepsNotifer.value += e.stepCount;
        totalCaloriesNotifer.value += e.caloBunred;
        totalDistancesNotifer.value += e.distance;
        totalTimeNotifer.value += (e.timeRunning / 3600);
        if(maxDistance < e.distance) maxDistance = e.distance;
      }
    }
    maxY = maxDistance+1;
  }

  void showChartInMonth() {
    data = runsThisMonth!;
    typeChartSC.add(TypeChart.month);
    titleNotifer.value = "This month";
    totalStepsNotifer.value = 0;
    totalCaloriesNotifer.value = 0;
    totalDistancesNotifer.value = 0;
    totalTimeNotifer.value = 0;
    double maxDistance = 0;
    for (var e in data) {
      if (e != null) {
        totalStepsNotifer.value += e.stepCount;
        totalCaloriesNotifer.value += e.caloBunred;
        totalDistancesNotifer.value += e.distance;
        totalTimeNotifer.value += (e.timeRunning / 3600);
        if(maxDistance < e.distance) maxDistance = e.distance;
      }
    }
    maxY = maxDistance+1;
  }

  void mokeData(int count) {
    Random random = Random();
    data.clear();
    data = List.generate(
      count,
      (index) => Run(
          runId: "1",
          key: 1,
          name: "Run 1",
          distance: random.nextInt(10).toDouble(),
          avgSpeed: 1,
          timeRunning: 1,
          caloBunred: 1,
          timeStart: DateTime.now(),
          stepCount: 10,
          location: "Hanoi"),
    );
  }
}
