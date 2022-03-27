import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/target/bloc/target_bloc.dart';

class TargetPage extends PageBase<TargetBloc> {
  TargetPage({Key? key}) : super(key: key);

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.isUpdateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.data!) {
          counter++;
        }
        return Center(child: Text("$counter"));
      },
    );
  }
}
