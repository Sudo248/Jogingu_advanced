import 'package:jogingu_advanced/app/base/global_data.dart';
import 'package:jogingu_advanced/app/pages/home/bloc/home_bloc.dart';
import 'package:jogingu_advanced/app/pages/main/bloc/main_bloc.dart';
import 'package:jogingu_advanced/app/pages/profile/bloc/profile_bloc.dart';
import 'package:jogingu_advanced/app/pages/run/bloc/run_bloc.dart';
import 'package:jogingu_advanced/app/pages/statistic/bloc/statistic_bloc.dart';
import 'package:jogingu_advanced/app/pages/target/bloc/target_bloc.dart';
import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:jogingu_advanced/data/config/setup_database.dart';
import 'package:jogingu_advanced/data/services/location_service.dart';
import 'package:jogingu_advanced/data/services/timer_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

Future<void> setupServiceLocator() async {
  final setupDatabse = setupDatabase();

  final getIt = GetIt.I;

  // register global data

  getIt.registerSingleton<GlobalData>(GlobalData());

  // register service

  getIt.registerLazySingleton<NavigatorService>(() => NavigatorService());
  getIt.registerFactory<LocationService>(() => LocationService());
  getIt.registerFactory<TimerService>(() => TimerService());

  // register bloc
  getIt.registerFactory<MainBloc>(() => MainBloc());
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
  getIt.registerFactory<TargetBloc>(() => TargetBloc());
  getIt.registerFactory<StatisticBloc>(() => StatisticBloc());
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc());
  getIt.registerFactory<RunBloc>(
      () => RunBloc(locationService: getIt.get<LocationService>()));

  // load variable from env
  dotenv.load();

  await setupDatabse;
}
