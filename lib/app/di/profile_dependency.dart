import 'package:jogingu_advanced/app/base/dependency.dart';
import 'package:jogingu_advanced/app/base/di.dart';
import 'package:jogingu_advanced/app/pages/profile/bloc/profile_bloc.dart';
import 'package:jogingu_advanced/domain/repositories/user_repository.dart';

class ProfileDependency implements Dependency{
  @override
  void dependencies() {
    Di.put<ProfileBloc>(() => ProfileBloc(repo: Di.get<UserRepository>()));
  }

}