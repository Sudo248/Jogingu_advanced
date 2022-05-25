import 'package:flutter/material.dart';

import 'dependency.dart';

class BaseFragmentRoute{
  final WidgetBuilder builder;
  final Dependency? dependency;
  final String? nameFragment;

  BaseFragmentRoute({required this.builder, this.dependency, this.nameFragment});

  Widget buildContent(BuildContext context){
    dependency?.dependencies();
    return builder(context);
  }

}