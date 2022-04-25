import 'package:jogingu_advanced/app/base/global_data.dart';
import 'package:jogingu_advanced/app/pages/home/bloc/home_bloc.dart';
import 'package:jogingu_advanced/app/pages/main/bloc/main_bloc.dart';
import 'package:jogingu_advanced/app/pages/profile/bloc/profile_bloc.dart';
import 'package:jogingu_advanced/app/pages/run/bloc/run_bloc.dart';
import 'package:jogingu_advanced/app/pages/splash/bloc/splash_bloc.dart';
import 'package:jogingu_advanced/app/pages/statistic/bloc/statistic_bloc.dart';
import 'package:jogingu_advanced/app/pages/target/bloc/edit_target_bloc.dart';
import 'package:jogingu_advanced/app/pages/target/bloc/target_bloc.dart';
import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:jogingu_advanced/data/config/boxes.dart';
import 'package:jogingu_advanced/data/config/setup_database.dart';
import 'package:jogingu_advanced/data/repositories/run_repository_impl.dart';
import 'package:jogingu_advanced/data/services/location_service.dart';
import 'package:jogingu_advanced/data/services/step_counter_service.dart';
import 'package:jogingu_advanced/data/services/timer_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';
import 'package:jogingu_advanced/domain/repositories/run_repository.dart';

void setupServiceLocator(){
  final getIt = GetIt.I;

  // register global data

  getIt.registerSingleton<GlobalData>(GlobalData());

  // register service,

  getIt.registerLazySingleton<NavigatorService>(() => NavigatorService());

  // load variable from env
  dotenv.load();
}
