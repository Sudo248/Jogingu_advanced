import 'package:flutter/material.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:jogingu_advanced/domain/common/run_state.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class RunActionButton extends StatefulWidget {
  final Stream<double>? distanceStream;
  final Stream<RunState>? runStateStream;
  final VoidCallback? onFinishClick;
  final VoidCallback? onPauseOrResumeClick;
  final VoidCallback? onStartClick;

  const RunActionButton({
    Key? key,
    required this.runStateStream,
    this.distanceStream,
    this.onFinishClick,
    this.onPauseOrResumeClick,
    this.onStartClick,
  }) : super(key: key);

  @override
  State<RunActionButton> createState() => _RunActionButtonState();
}

class _RunActionButtonState extends State<RunActionButton> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return StreamBuilder<RunState>(
        stream: widget.runStateStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          RunState runState = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: runState == RunState.pause,
                maintainSize: false,
                maintainState: false,
                child: SizedBox.square(
                  dimension: widthScreen * 0.15,
                  child: FloatingActionButton(
                    heroTag: "Finish button",
                    onPressed: widget.onFinishClick,
                    backgroundColor: AppColors.primaryColorDarkPlus,
                    child: const Text(
                      "Finish",
                      style: AppStyles.h5,
                    ),
                  ),
                ),
              ),
              runState == RunState.start
                  ? FloatingActionButton.large(
                      heroTag: "Start button",
                      onPressed: widget.onStartClick,
                      backgroundColor: AppColors.primaryColorDarkPlus,
                      child: const Text(
                        "Start",
                        style: AppStyles.h4,
                      ),
                    )
                  : SizedBox.square(
                      dimension: widthScreen * 0.3,
                      child: FloatingActionButton(
                        heroTag: "Disctance container",
                        onPressed: null,
                        backgroundColor: AppColors.primaryColorDarkPlus,
                        child: FittedBox(
                          child: Column(
                            children: [
                              StreamBuilder<double>(
                                stream: widget.distanceStream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox.shrink();
                                  }
                                  return Text(
                                    snapshot.data!.toStringAsFixed(2),
                                    style: AppStyles.h3,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "km",
                                style: AppStyles.h5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              Visibility(
                visible: runState != RunState.start,
                child: SizedBox.square(
                  dimension: widthScreen * 0.15,
                  child: FloatingActionButton(
                    heroTag: "Pause or Resume container",
                    onPressed: widget.onPauseOrResumeClick,
                    backgroundColor: AppColors.primaryColorDarkPlus,
                    child: runState == RunState.running
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow),
                  ),
                ),
              )
            ],
          );
        });
  }
}
