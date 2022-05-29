import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogingu_advanced/app/base/base_fragment_route.dart';
import 'package:jogingu_advanced/app/base/base_page.dart';
import 'package:jogingu_advanced/app/components/bottom_navigation_app_bar.dart';
import 'package:jogingu_advanced/app/pages/main/bloc/main_bloc.dart';
import 'package:jogingu_advanced/app/routes/app_routes.dart';
import 'package:jogingu_advanced/app/utils/dialog.dart';

import '../../../../resources/app_assets.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';

class MainPage extends BasePage<MainBloc> {
  late final Size size;

  MainPage({Key? key}) : super(key: key) {
    size = bloc.globalData.size;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: StreamBuilder<BaseFragmentRoute>(
          stream: bloc.fragmentStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            String title = snapshot.data?.nameFragment ?? "Unknow";
            return Text(
              title,
              style: AppStyles.h4
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            );
          },
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => bloc.navigateToPage(AppRoutes.about),
            icon: Image.asset(AppAssets.logo_rouned),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: StreamBuilder<BaseFragmentRoute>(
        stream: bloc.fragmentStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          return SingleChildScrollView(
            key: GlobalKey(),
            child: Column(
              children: [
                snapshot.data!.buildContent(context),
                SizedBox(
                  height: size.width / 9.0,
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationAppBar(
        items: const [
          ItemBottomAppBar(
            icon: Icon(Icons.home),
            label: AppRoutes.home,
          ),
          ItemBottomAppBar(
            icon: Icon(Icons.gps_fixed_outlined),
            label: AppRoutes.target,
          ),
          ItemBottomAppBar(
            icon: Icon(Icons.add_chart_rounded),
            label: AppRoutes.statistic,
          ),
          ItemBottomAppBar(
            icon: Icon(Icons.manage_accounts),
            label: AppRoutes.profile,
          ),
        ],
        onTapItem: (index) => bloc.navigateToFragment(index),
        showUnisSelectedLabels: false,
        backgroundColor: Colors.white,
        isSelectedItemColor: AppColors.primaryColor,
		// elevation: -50,
        notchMargin: size.height / 120,
        height: size.height / 14,
      ),
      floatingActionButton: SizedBox.square(
        dimension: size.width / 5.3,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () => onClickRun(context),
            child: const Text(
              "Run",
              style: AppStyles.h5,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onClickRun(BuildContext context) async {
    if (await bloc.canRun) {
      bloc.navigateOffToPage(AppRoutes.run);
    } else {
      showJoginguAlertDialog(
        context,
        content: Text(
          "You have to fill your profile before run.",
          style: AppStyles.h5.copyWith(
            color: Colors.black,
          ),
        ),
        onClick: bloc.prepareToRun,
      );
    }
  }
}
