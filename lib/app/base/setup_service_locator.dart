import 'package:jogingu_advanced/app/base/global_data.dart';
import 'package:jogingu_advanced/app/base/di.dart';
import 'package:jogingu_advanced/app/service/image_service.dart';
import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jogingu_advanced/app/service/notification_service.dart';
import 'package:jogingu_advanced/app/service/text_to_speech_service.dart';
import 'package:jogingu_advanced/data/config/setup_database.dart';

import '../../data/repositories/run_repository_impl.dart';
import '../../data/repositories/target_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/shared_preference/app_pref.dart';
import '../../data/shared_preference/target_pref.dart';
import '../../domain/repositories/run_repository.dart';
import '../../domain/repositories/target_repository.dart';
import '../../domain/repositories/user_repository.dart';

Future<void> setupServiceLocator() async {
  Di.lazyPut<NavigatorService>(() => NavigatorService());

  Di.lazyPut<GlobalData>(
      () => GlobalData(appContext: Di.get<NavigatorService>().currentContext));

  Di.lazyPut<NotificationService>(() => NotificationService());

  Di.lazyPut<ImageService>(() => ImageService());

  Di.lazyPut<TextToSpeechService>(() => TextToSpeechService());

  Di.lazyPut<AppPref>(() => AppPref());

  Di.lazyPut<TargetPref>(() => TargetPref());

  Di.lazyPut<RunRepository>(
    () => RunRepositoryImpl(),
  );

  Di.lazyPut<TargetRepository>(
      () => TargetRepositoryImpl(pref: Di.get<TargetPref>()));

  Di.lazyPut<UserRepository>(() => UserRepositoryImpl());

  // load variable from env
  dotenv.load();
}
