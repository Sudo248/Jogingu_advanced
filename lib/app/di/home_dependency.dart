import 'package:jogingu_advanced/app/pages/main/fragments/home/bloc/home_bloc.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:jogingu_advanced/domain/repositories/user_repository.dart';

import '../base/dependency.dart';
import '../base/di.dart';

class HomeDependency implements Dependency{
  @override
  void dependencies() {
    Di.put<HomeBloc>(() => HomeBloc(runRepo: Di.get<RunRepository>(), userRepo: Di.get<UserRepository>()));
  }

}