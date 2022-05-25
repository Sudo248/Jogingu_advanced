import 'package:jogingu_advanced/app/base/dependency.dart';
import 'package:jogingu_advanced/app/pages/main/fragments/target/bloc/edit_target_bloc.dart';
import 'package:jogingu_advanced/app/service/notification_service.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';

import '../base/di.dart';

class EditTargetDependency implements Dependency {
  @override
  void dependencies() {
    Di.put<EditTargetBloc>(
      () => EditTargetBloc(
        notificationService: Di.get<NotificationService>(),
        pref: Di.get<TargetPref>(),
      ),
    );
  }
}
