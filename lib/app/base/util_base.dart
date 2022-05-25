import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/service/navigator_sevice.dart';
import 'package:get_it/get_it.dart';

import 'di.dart';
import 'global_data.dart';

mixin UtilBase {
  final navigator = Di.get<NavigatorService>();
  final globalData = Di.get<GlobalData>();
  
}
