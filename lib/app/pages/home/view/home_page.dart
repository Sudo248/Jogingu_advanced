import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/components/item_run.dart';
import 'package:jogingu_advanced/app/pages/home/bloc/home_bloc.dart';

class HomePage extends PageBase<HomeBloc> {
  late Size size;
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ItemRun(
      height: size.height * 0.66,
    );
  }
}
