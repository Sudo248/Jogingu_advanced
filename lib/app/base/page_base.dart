
import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:get_it/get_it.dart';

abstract class PageBase<@required T extends BlocBase> extends StatefulWidget {
  final T _bloc = GetIt.I.get<T>();
  T get bloc => _bloc;

  PageBase({Key? key}) : super(key: key);

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
  State<PageBase> createState() => _PageBaseState();
}

class _PageBaseState extends State<PageBase> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}
