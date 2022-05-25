import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/base_fragment.dart';
import 'package:jogingu_advanced/app/components/button.dart';
import 'package:jogingu_advanced/app/components/item_target.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../bloc/target_bloc.dart';

class TargetFragment extends BaseFragment<TargetBloc> {
  TargetFragment({Key? key}) : super(key: key, name: AppRoutes.target);

  @override
  Widget build(BuildContext context) {
    print("build TargetFragment");
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ItemTarget(
              title: "Distance",
              contentValue: bloc.distance,
            ),
            ItemTarget(
              title: "Calo",
              contentValue: bloc.calo,
            ),
            ItemTarget(
              title: "Start at",
              contentValue: bloc.timeStart,
            ),
            ItemTarget(
              title: "Place",
              contentValue: bloc.place,
            ),
            // ItemTarget(
            //   title: "Recursive",
            //   contentValue: bloc.recursive,
            // ),
            // ItemTarget(
            //   title: "Notification",
            //   contentValue: bloc.notifyBefore,
            // ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Button(
          onPressed: () {
            bloc.navigateToPage(AppRoutes.editTarget);
          },
          primary: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          size: Size(size.width * 0.8, 50),
          child: const Text(
            "Edit target",
            style: AppStyles.h4,
          ),
        ),
      ],
    );
  }
}
