import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/utils/chart.dart';
import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:jogingu_advanced/domain/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

import '../../../../../../domain/entities/run.dart';

class StatisticBloc extends BlocBase {
  late List<Run?> data;
  double? maxY;

  final RunRepository runRepo;
  final UserRepository userRepo;

  ValueNotifier<String> username = ValueNotifier("");

  StatisticBloc({required this.runRepo, required this.userRepo}) {
    print("onInit StatisticBloc getName");
    userRepo.getName().then((value) {
      if (value.isSuccess) {
        username.value = value.data ?? "";
      }
    });
  }

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

  BehaviorSubject<TypeChart> typeChartSC =
      BehaviorSubject.seeded(TypeChart.day);

  @override
  void onDispose() {
    // print("on dispose statistic bloc");
    runsThisDay = null;
    runsThisWeek = null;
    runsThisMonth = null;
    data.clear();
    typeChartSC.close();
  }

  @override
  void onInit() async {
    // // TODO: implement onInit
    // mokeData(24);
    // typeChartSC.add(TypeChart.day);
    // print("on init statistic bloc");

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

    runRepo.getRunsThisDay().listen((event) {
      //   print("init get run this day");
      if (event.isSuccess) {
        runsThisDay = event.data;
        showCharInDay();
      }
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
      runRepo.getRunsThisWeek().listen((event) {
        if (event.isSuccess) {
          runsThisWeek = event.data;
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
      runRepo.getRunsThisMonth().listen((event) {
        if (event.isSuccess) {
          runsThisMonth = event.data;
          //   while (runsThisMonth!.length < 7) {
          //     runsThisMonth!.add(null);
          //   }
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
    data = runsThisDay ?? List.empty();
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
        if (maxDistance < e.distance) maxDistance = e.distance;
      }
    }
    maxY = maxDistance + 1;
    typeChartSC.add(TypeChart.day);
  }

  void showChartInWeek() {
    data = runsThisWeek ?? List.empty();
    titleNotifer.value = "This week";
    totalStepsNotifer.value = 0;
    totalCaloriesNotifer.value = 0;
    totalDistancesNotifer.value = 0;
    totalTimeNotifer.value = 0;
    double maxDistance = 0;
    for (Run? run in data) {
      if (run != null) {
        totalStepsNotifer.value += run.stepCount;
        totalCaloriesNotifer.value += run.caloBunred;
        totalDistancesNotifer.value += run.distance;
        totalTimeNotifer.value += (run.timeRunning / 3600);
        if (maxDistance < run.distance) maxDistance = run.distance;
      }
    }
    maxY = maxDistance + 1;
    typeChartSC.add(TypeChart.week);
  }

  void showChartInMonth() {
    data = runsThisMonth ?? List.empty();
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
        if (maxDistance < e.distance) maxDistance = e.distance;
      }
    }
    maxY = maxDistance + 1;
    typeChartSC.add(TypeChart.month);
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
