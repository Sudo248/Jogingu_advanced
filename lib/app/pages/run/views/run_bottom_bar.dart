import 'package:flutter/material.dart';
import 'package:jogingu_advanced/domain/utils/extensions.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class RunBottomBar extends StatefulWidget {
  final Stream<double>? speedStream;
  final Stream<int>? timeStream;
  final Stream<int>? stepStream;
  final Function(AnimationController controller) onInit;
  final double? height;
  final double? ratio;
  final Duration? duration;
  final Widget? actionButton;

  const RunBottomBar({
    Key? key,
    required this.onInit,
    this.speedStream,
    this.timeStream,
    this.stepStream,
    this.height,
    this.ratio = 0.0,
    this.duration,
    this.actionButton,
  }) : super(key: key);

  @override
  State<RunBottomBar> createState() => _RunBottomBarState();
}

class _RunBottomBarState extends State<RunBottomBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> expandAnimation;
  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 200),
    );
    expandAnimation = Tween(
      begin: widget.ratio,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
    controller.reverse();
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.reverse) {
        isExpand = false;
      } else if (status == AnimationStatus.forward) {
        isExpand = true;
      }
    });
    widget.onInit(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            if (isExpand) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 0.5],
                colors: [
                  Colors.transparent,
                  AppColors.primaryColor,
                ],
              ),
            ),
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: widget.actionButton,
          ),
        ),
        _content(
          widthScreen,
        )
      ],
    );
  }

  Widget _content(double widthScreen) => InkWell(
        onTap: () async {
          if (isExpand) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: SizeTransition(
          axisAlignment: -1,
          sizeFactor: expandAnimation,
          child: Container(
            color: AppColors.primaryColor,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                itemBar(
                  icon: Icon(
                    Icons.thermostat_auto_outlined,
                    size: 42,
                  ),
                  content: StreamBuilder<double>(
                      stream: widget.speedStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return Text(
                          snapshot.data!.toStringAsFixed(2),
                          style: AppStyles.h4,
                        );
                      }),
                  label: Text(
                    "Speed",
                    style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                itemBar(
                    icon: Icon(
                      Icons.alarm,
                      size: 42,
                    ),
                    content: StreamBuilder<int>(
                        stream: widget.timeStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const SizedBox.shrink();
                          return Text(
                            snapshot.data!.toTime(),
                            style: AppStyles.h4,
                          );
                        }),
                    label: Text(
                      "Time",
                      style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                    ),
                    isCenter: true),
                itemBar(
                  icon: Icon(
                    Icons.directions_run_outlined,
                    size: 42,
                  ),
                  content: StreamBuilder<int>(
                      stream: widget.stepStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox.shrink();
                        return Text(
                          "${snapshot.data}",
                          style: AppStyles.h4,
                        );
                      }),
                  label: Text(
                    "Step",
                    style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget itemBar({
    required Widget icon,
    required Widget content,
    required Widget label,
    bool isCenter = false,
  }) {
    return FittedBox(
      child: Column(
        children: [
          isCenter
              ? const SizedBox(
                  height: 32,
                )
              : const SizedBox.shrink(),
          icon,
          const SizedBox(
            height: 8,
          ),
          content,
          const SizedBox(
            height: 10,
          ),
          label,
          !isCenter
              ? const SizedBox(
                  height: 32,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
