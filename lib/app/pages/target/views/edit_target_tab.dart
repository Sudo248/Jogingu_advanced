import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/components/button.dart';
import 'package:jogingu_advanced/app/components/text_field_none_validate.dart';
import 'package:jogingu_advanced/app/pages/target/bloc/edit_target_bloc.dart';
import 'package:jogingu_advanced/app/utils/dialog.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class EditTargetPage extends PageBase<EditTargetBloc> {
  EditTargetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bloc.updateTimeStart(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Edit Target",
          style:
              AppStyles.h4.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldNoneValidate(
                    controller: bloc.distanceCtrl,
                    labelText: "Distance /day",
                    keyboardType: TextInputType.number,
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  TextFieldNoneValidate(
                    controller: bloc.caloCtrl,
                    labelText: "Calo /day",
                    keyboardType: TextInputType.number,
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  TextFieldNoneValidate(
                    controller: bloc.timeStartCtrl,
                    labelText: "Start at",
                    readOnly: true,
                    suffix: const Icon(
                      Icons.access_time,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () async {
                      final time = await showJoginguTimePicker(context);
                      bloc.pickTime = time;
                      bloc.updateTimeStart(context);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  TextFieldNoneValidate(
                    controller: bloc.placeCtrl,
                    labelText: "Place",
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  TextFieldNoneValidate(
                    controller: bloc.recursiveCtrl,
                    labelText: "Recursive /times",
                    keyboardType: TextInputType.number,
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  TextFieldNoneValidate(
                    controller: bloc.notifyBeforeCtrl,
                    labelText: "Notify before /minutes",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Button(
                    onPressed: bloc.saveTarget,
                    primary: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    size: Size(size.width * 0.8, 50),
                    child: const Text(
                      "Save",
                      style: AppStyles.h4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          if (bloc.onChange) {
            showJoginguConfirmDialog(
              context,
              title: const FittedBox(
                child: Text("Do you want save this target"),
              ),
              content: const Text("Please save change before back."),
              onNegative: () {
                bloc.navigator.back();
                bloc.navigator.back();
              },
              onPositive: () => bloc.saveTarget(),
            );
            return Future.value(false);
          }

          return Future.value(true);
        },
      ),
    );
  }
}
