import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/components/button.dart';
import 'package:jogingu_advanced/app/components/choose_day_month.dart';
import 'package:jogingu_advanced/app/pages/statistic/bloc/statistic_bloc.dart';
import 'package:jogingu_advanced/app/utils/chart.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class StatisticPage extends PageBase<StatisticBloc> {
  StatisticPage({Key? key}) : super(key: key);

  final Key chartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: "Hi! ",
              style: AppStyles.h4.copyWith(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "Sudo\n",
                  style: AppStyles.h4.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        "The chart below shows your training progress\nover time",
                    style: AppStyles.h5.copyWith(
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            shadowColor: Colors.grey.shade500,
            elevation: 6,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ChooseDayMonth(
                  onItemClick: (index) {
                    if (index == 0) {
                      bloc.onDayClick();
                    } else if (index == 1) {
                      bloc.onWeekClick();
                    } else {
                      bloc.onMonthClick();
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "km",
                      style: AppStyles.h5.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: StreamBuilder(
                    stream: bloc.typeChartSC.stream,
                    builder: (ctx, snapshot) {
                      if (!snapshot.hasData) {
                        return JoginguChart(
                          key: chartKey,
                          data: bloc.data,
                          maxY: 20,
                        );
                      } /*const SizedBox.shrink();*/
                      //   final runData = snapshot.data as Map<String, dynamic>;
                      
                      return JoginguChart(
                        key: chartKey,
                        data: bloc.data,
                        type: snapshot.data as TypeChart,
                        maxY: bloc.maxY ?? 10,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ValueListenableBuilder(
              valueListenable: bloc.titleNotifer,
              builder: (ctx, String value, child) {
                return Text(
                  value,
                  style: AppStyles.h3.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: [
              itemIntTotal("Steps", bloc.totalStepsNotifer),
              itemDoubleTotal("Calories", bloc.totalCaloriesNotifer),
              itemDoubleTotal(
                "Time",
                bloc.totalTimeNotifer,
                verticalDirection: VerticalDirection.up,
              ),
              itemDoubleTotal(
                "km",
                bloc.totalDistancesNotifer,
                verticalDirection: VerticalDirection.up,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget itemIntTotal(String title, ValueNotifier<int> valueNotifer,
      {VerticalDirection verticalDirection = VerticalDirection.down}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        verticalDirection: verticalDirection,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyles.h4,
          ),
          const SizedBox(
            height: 5,
          ),
          ValueListenableBuilder<int>(
            valueListenable: valueNotifer,
            builder: (context, int value, child) {
              return Text(
                "$value",
                style: AppStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemDoubleTotal(String title, ValueNotifier<double> valueNotifer,
      {VerticalDirection verticalDirection = VerticalDirection.down}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        verticalDirection: verticalDirection,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyles.h4,
          ),
          const SizedBox(
            height: 5,
          ),
          ValueListenableBuilder<double>(
            valueListenable: valueNotifer,
            builder: (context, double value, child) {
              return Text(
                value.toStringAsFixed(2),
                style: AppStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
