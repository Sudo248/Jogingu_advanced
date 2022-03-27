import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:get_it/get_it.dart';

import 'global_data.dart';

mixin UtilBase {
  final navigator = GetIt.I.get<NavigatorService>();
  final globalData = GetIt.I.get<GlobalData>();
}
