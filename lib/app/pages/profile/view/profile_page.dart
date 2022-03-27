import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/profile/bloc/profile_bloc.dart';

class ProfilePage extends PageBase<ProfileBloc>{
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("ProfilePage"),
    );
  }
	
}