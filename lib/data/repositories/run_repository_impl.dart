import 'package:jogingu_advanced/data/config/boxes.dart';
import 'package:jogingu_advanced/data/extensions/run_extention.dart';
import 'package:jogingu_advanced/domain/common/failure.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:jogingu_advanced/domain/entities/run.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/common/status.dart';
import '../models/run_model.dart';

class RunRepositoryImpl implements RunRepository {
  Box<RunModel>? runBox;

  @override
  Future<void> onDispose() async {}

  @override
  Future<void> onInit() async {}

  @override
  Future<Status> delete(dynamic key) async {
    try {
      runBox = await Boxes.I.runBox;
      await runBox?.delete(key);
      await runBox?.compact();
      Logger.success(message: "delete run $key");
      runBox?.close();
      return Future.value(Success());
    } catch (e) {
      Logger.error(message: "delete run $key");
      runBox?.close();
      return Future.value(Error(const DefaultError("Error when delete run")));
    }
  }

  @override
  Future<Status> add(Run run) async {
    try {
      runBox = await Boxes.I.runBox;
      await runBox?.add(run.toRunModel());
      Logger.success(message: "add run");
      runBox?.close();
      return Future.value(Success());
    } catch (e) {
      Logger.error(message: "add run $e");
      runBox?.close();
      return Error(const DefaultError("Error when add run"));
    }
  }

  @override
  Stream<Status<List<Run>>> getAll([dynamic key]) async* {
    yield Loading();
    runBox = await Boxes.I.runBox;
    try {
      final runs = runBox?.values.map((e) => e.toRun()).toList();
      yield Success(runs);
      Logger.success(message: "get all run");
      runBox?.close();
    } catch (e) {
      Logger.error(message: "get all run: $e");
      yield Error(const DefaultError("Error when get run"));
      runBox?.close();
    }
  }

  @override
  Future<Status> update(key, Run data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Status<List<Run>>> take({int skip = 0, int take = 10}) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Future<Status<Run>> get(key) async {
    try {
      runBox = await Boxes.I.runBox;
      final run = runBox?.get(key);
      if (run == null) {
        throw DefaultError("Not found run $key");
      }
      runBox?.close();
      return Future.value(Success(run.toRun()));
    } catch (e) {
      Logger.error(message: "get run: $e");
      runBox?.close();
      if (e is Failure) {
        return Future.value(Error(e));
      }

      return Future.value(Error(const DefaultError("Error when get run")));
    }
  }

  Future<List<Run>> getRunsFromTimeInDay(int timeStartInMiliseconds) async{
    try {
      if (runBox == null || runBox!.isEmpty) return List.empty();
      List<Run> res = List.empty(growable: true);
      for (RunModel runModel in runBox!.values) {
        if (runModel.timeStartInMiliseconds >= timeStartInMiliseconds) {
          res.add(runModel.toRun());
        }
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<Status<List<Run?>>> getRunsThisDay() async* {
    // Logger.debug(message: "getRunsThisDay");
    runBox = await Boxes.I.runBox;
    try {
      final dateTime = DateTime.now();
      final today = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
      );

      final runsThisDay = await getRunsFromTimeInDay(today.millisecondsSinceEpoch);
      
      final List<Run?> result = List.generate(24, (index) => null);
	
      for (Run run in runsThisDay) {
        result[run.timeStart.hour] = run;
      }
      yield Success(result);
      runBox?.close();
    } catch (e) {
      Logger.error(message: "get run this day: $e");
      if (e is Failure) {
        yield Error(e);
      } else {
        yield Error(const DefaultError("Error when get run this day"));
      }

      runBox?.close();
    }
  }

  @override
  Stream<Status<List<Run?>>> getRunsThisWeek() async* {
    runBox = await Boxes.I.runBox;
    try {
      final dateTime = DateTime.now();
      final monday = dateTime.subtract(Duration(days: dateTime.weekday - 1));
      final runsThisWeek = await getRunsFromTimeInDay(monday.millisecondsSinceEpoch);
      final List<Run?> result = List.generate(7, (index) => null);
	  
      for (Run run in runsThisWeek) {
		  if(result[run.timeStart.weekday - 1] == null){
			  result[run.timeStart.weekday - 1] = run;
		  }else{
			  result[run.timeStart.weekday - 1] = result[run.timeStart.weekday - 1]!.plus(run);
		  }
      }
      yield Success(result);
      runBox?.close();
    } catch (e) {
      Logger.error(message: "get run this week: $e");
      if (e is Failure) {
        yield Error(e);
      } else {
        yield Error(const DefaultError("Error when get run this week"));
      }
      runBox?.close();
    }
  }

  @override
  Stream<Status<List<Run?>>> getRunsThisMonth() async* {
    runBox = await Boxes.I.runBox;
    try {
      final dateTime = DateTime.now();
      final theFirstDayOfThisMonth =
          dateTime.subtract(Duration(days: dateTime.day - 1));
      final runsThisMonth =
          await getRunsFromTimeInDay(theFirstDayOfThisMonth.millisecondsSinceEpoch);
      final List<Run?> result = List.generate(31, (index) => null);
      for (Run run in runsThisMonth) {
        if(result[run.timeStart.weekday - 1] == null){
			  result[run.timeStart.weekday - 1] = run;
		  }else{
			  result[run.timeStart.weekday - 1] = result[run.timeStart.weekday - 1]!.plus(run);
		  }
      }
      yield Success(result);
      runBox?.close();
    } catch (e) {
      Logger.error(message: "get run this month: $e");
      if (e is Failure) {
        yield Error(e);
      } else {
        yield Error(const DefaultError("Error when get run this month"));
      }
      runBox?.close();
    }
  }
}
