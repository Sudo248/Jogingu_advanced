import 'package:jogingu_advanced/domain/common/status.dart';
import 'package:jogingu_advanced/domain/entities/run.dart';
import 'package:jogingu_advanced/domain/repositories/repository.dart';

abstract class RunRepository extends Repositoty<Run> {
  Stream<Status<List<Run>>> take({int skip = 0, int take = 10});
  Stream<Status<List<Run?>>> getRunsThisDay();
  Stream<Status<List<Run?>>> getRunsThisWeek();
  Stream<Status<List<Run?>>> getRunsThisMonth();
}
