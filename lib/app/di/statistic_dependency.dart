import 'package:jogingu_advanced/app/base/dependency.dart';
import 'package:jogingu_advanced/app/pages/main/fragments/statistic/bloc/statistic_bloc.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:jogingu_advanced/domain/repositories/user_repository.dart';

import '../base/di.dart';

class StatisticDependency implements Dependency{
  @override
  void dependencies() {
    Di.put<StatisticBloc>(() => StatisticBloc(runRepo: Di.get<RunRepository>(), userRepo: Di.get<UserRepository>()));
  }
}