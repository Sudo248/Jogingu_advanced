import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../domain/entities/run.dart';

enum TypeChart {
  day,
  week,
  month,
}

class JoginguChart extends StatelessWidget {
  final List<Run?> data;
  final double maxY;
  final TypeChart type;

  const JoginguChart({
    Key? key,
    required this.data,
    this.type = TypeChart.week,
    required this.maxY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          titlesData: titlesData,
          barGroups: barGroups,
          barTouchData: barTouchData,
          borderData: borderData,
          maxY: maxY,
        ),
        swapAnimationDuration: const Duration(milliseconds: 500),
        swapAnimationCurve: Curves.decelerate,
      ),
    );
  }

  Widget bottomWeekTitles(double value, TitleMeta meta) {
    String text = "";

    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }

    return Center(
      child: Text(
        text,
        style: AppStyles.h5.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bottomDayTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: AppColors.primaryColor, fontSize: 10);
    final index = value.toInt();
    String text = index == 23 || index % 4 == 0 ? "$index" : "";
    return Center(child: Text(text, style: style));
  }

  Widget bottomMonthTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: AppColors.primaryColor, fontSize: 10);
    final index = value.toInt() + 1;
    String text = index == 1 || index % 5 == 0 ? "$index" : "";
    return Center(child: Text(text, style: style));
  }

  List<BarChartGroupData>? get barGroups {
    if (data.isEmpty) return null;
    int index = 0;
    return data
        .map(
          (run) => run == null
              ? BarChartGroupData(x: index++)
              : BarChartGroupData(
                  x: index++,
                  groupVertically: true,
                  barRods: [
                    BarChartRodData(
                      toY: run.distance,
                      width: type == TypeChart.week ? 24 : null,
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(type == TypeChart.week ? 5 : 2),
                        topRight:
                            Radius.circular(type == TypeChart.week ? 5 : 2),
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColorDarkPlus,
                        width: 0.5,
                      ),
                    ),
                  ],
                  showingTooltipIndicators:
                      type == TypeChart.week && run.distance != 0 ? [0] : [],
                ),
        )
        .toList();
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipMargin: 0,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                "${rod.toY}",
                AppStyles.h5.copyWith(color: rod.color),
              );
            }),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          drawBehindEverything: true,
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(1),
                style: AppStyles.h6.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
        // leftTitles: AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              if (type == TypeChart.day) {
                return bottomDayTitles(value, meta);
              } else if (type == TypeChart.week) {
                return bottomWeekTitles(value, meta);
              } else {
                return bottomMonthTitles(value, meta);
              }
            },
          ),
        ),
        topTitles: AxisTitles(),
        rightTitles: AxisTitles(),
      );

  FlBorderData get borderData {
    return FlBorderData(
      show: true,
      border: const Border(
        left: BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }
}
