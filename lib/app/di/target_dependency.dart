import 'package:jogingu_advanced/app/base/dependency.dart';
import 'package:jogingu_advanced/app/pages/main/fragments/target/bloc/target_bloc.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';

import '../base/di.dart';

class TargetDependency implements Dependency{
  @override
  void dependencies() {
    Di.put<TargetBloc>(() => TargetBloc(pref: Di.get<TargetPref>()));
  }

}