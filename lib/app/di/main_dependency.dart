import 'package:jogingu_advanced/app/base/dependency.dart';
import 'package:jogingu_advanced/app/base/di.dart';

import '../../data/shared_preference/app_pref.dart';
import '../pages/main/bloc/main_bloc.dart';

class MainDependency implements Dependency{
  @override
  void dependencies() {
    Di.put<MainBloc>(() => MainBloc(pref: Di.get<AppPref>()));
  }

}