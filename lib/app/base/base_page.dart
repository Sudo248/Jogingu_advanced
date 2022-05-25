
import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';

import 'di.dart';


abstract class BasePage<@required T extends BlocBase> extends StatefulWidget {
  final T _bloc = Di.get<T>();
  T get bloc => _bloc;

  BasePage({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  @mustCallSuper
  void onInit() {
    bloc.onInit();
    Logger.success(message: "onInit ${toString()}");
  }

  @mustCallSuper
  void onDispose() {
    bloc.onDispose();
    Logger.success(message: "onDispose ${toString()}");
  }

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}
