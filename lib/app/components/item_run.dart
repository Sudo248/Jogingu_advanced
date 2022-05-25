import 'package:flutter/material.dart';
import 'package:jogingu_advanced/domain/utils/extensions.dart';
import 'package:jogingu_advanced/resources/app_assets.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../domain/entities/run.dart';
import '../utils/util.dart' show formatTime;

class ItemRun extends StatelessWidget {
  final double height;
  final Run run;
  final Function(int id) onMenuClick;
  final ImageProvider<Object>? avatar;
  final String? username;
  const ItemRun({
    Key? key,
    required this.height,
    required this.run,
    required this.onMenuClick,
	this.avatar,
	this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 8,
      color: AppColors.carBackground,
      child: Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        width: double.infinity,
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                      run.name,
                      style: AppStyles.h4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: height / 40,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _itemRunInfo(
                      "Distance", "${run.distance.toStringAsFixed(2)} km"),
                  const VerticalDivider(
                    thickness: 2,
                  ),
                  _itemRunInfo(
                      "Pace", "${run.avgSpeed.toStringAsFixed(2)} /km"),
                  const VerticalDivider(
                    thickness: 2,
                  ),
                  _itemRunInfo("Time", run.timeRunning.toTime()),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Expanded(
              child: Image.network(
                run.image ??
                    "https://www.dungplus.com/wp-content/uploads/2019/12/girl-xinh-1-480x600.jpg",
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: avatar ?? const AssetImage(AppAssets.avatar),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username ?? "Sudo",
                style: AppStyles.h5.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${formatTime(run.timeStart)} - ${run.location}",
                style: AppStyles.h6.copyWith(color: Colors.black),
                maxLines: 2,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            onMenuClick(run.key);
          },
          child: const Icon(
            Icons.more_horiz,
          ),
        ),
      ],
    );
  }

  Widget _itemRunInfo(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppStyles.h6.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          content,
          style: AppStyles.h5.copyWith(
            color: Colors.black,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
