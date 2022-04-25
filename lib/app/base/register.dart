import 'package:jogingu_advanced/app/base/global_data.dart';
import 'package:jogingu_advanced/app/pages/home/bloc/home_bloc.dart';
import 'package:jogingu_advanced/app/pages/main/bloc/main_bloc.dart';
import 'package:jogingu_advanced/app/pages/profile/bloc/profile_bloc.dart';
import 'package:jogingu_advanced/app/pages/run/bloc/run_bloc.dart';
import 'package:jogingu_advanced/app/pages/splash/bloc/splash_bloc.dart';
import 'package:jogingu_advanced/app/pages/statistic/bloc/statistic_bloc.dart';
import 'package:jogingu_advanced/app/pages/target/bloc/edit_target_bloc.dart';
import 'package:jogingu_advanced/app/pages/target/bloc/target_bloc.dart';
import 'package:jogingu_advanced/data/config/setup_database.dart';
import 'package:jogingu_advanced/data/repositories/run_repository_impl.dart';
import 'package:jogingu_advanced/data/repositories/target_repository_impl.dart';
import 'package:jogingu_advanced/data/services/location_service.dart';
import 'package:jogingu_advanced/data/services/step_counter_service.dart';
import 'package:jogingu_advanced/data/services/timer_service.dart';
import 'package:get_it/get_it.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';
import 'package:jogingu_advanced/domain/repositories/target_repository.dart';

Future<void> register() async {
  final setupDatabse = setupDatabase();

  final getIt = GetIt.I;

  // register service,

  getIt.registerFactory<LocationService>(() => LocationService());
  getIt.registerFactory<TimerService>(() => TimerService());
  getIt.registerFactory<StepCounterService>(() => StepCounterService());

  // register pref

  getIt.registerLazySingleton<TargetPref>(() => TargetPref());

  // register repository

  getIt.registerLazySingleton<RunRepository>(
    () => RunRepositoryImpl(),
  );

  getIt.registerLazySingleton<TargetRepository>(
      () => TargetRepositoryImpl(pref: getIt.get<TargetPref>()));

  // register bloc
  getIt.registerFactory<SplashBloc>(() => SplashBloc());

  getIt.registerFactory<MainBloc>(() => MainBloc());

  getIt.registerFactory<HomeBloc>(() => HomeBloc(
        repository: getIt.get<RunRepository>(),
      ));

  getIt.registerFactory<TargetBloc>(() => TargetBloc(
        pref: getIt.get<TargetPref>(),
      ));

  getIt.registerFactory<StatisticBloc>(() => StatisticBloc(
        repo: getIt.get<RunRepository>(),
      ));

  getIt.registerFactory<ProfileBloc>(() => ProfileBloc());

  getIt.registerFactory<RunBloc>(
    () => RunBloc(
      locationService: getIt.get<LocationService>(),
      timerService: getIt.get<TimerService>(),
      stepCounterService: getIt.get<StepCounterService>(),
      repository: getIt.get<RunRepository>(),
    ),
  );

  getIt.registerFactory<EditTargetBloc>(
      () => EditTargetBloc(pref: getIt.get<TargetPref>()));

  await setupDatabse;
}
