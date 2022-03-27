import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/statistic/bloc/statistic_bloc.dart';

class StatisticPage extends PageBase<StatisticBloc>{
  StatisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("StatisticPage"),
    );
  }
	
}