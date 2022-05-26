import 'package:flutter/material.dart';
import 'package:jogingu_advanced/domain/utils/extensions.dart';
import 'package:jogingu_advanced/resources/app_assets.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

import '../../domain/entities/run.dart';
import '../utils/util.dart' show formatTime, getImageProvider;

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
                    _Title(
                      avatar: avatar,
                      username: username,
                      timeStart: run.timeStart,
                      location: run.location,
                      onMenuClick: () => onMenuClick(run.key),
                    ),
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
                  _ItemRunInfo(
                      title: "Distance", content: "${run.distance.toStringAsFixed(2)} km"),
                  const VerticalDivider(
                    thickness: 2,
                  ),
                  _ItemRunInfo(
                     title: "Pace", content: "${run.avgSpeed.toStringAsFixed(2)} /km"),
                  const VerticalDivider(
                    thickness: 2,
                  ),
                  _ItemRunInfo(title: "Time", content: run.timeRunning.toTime()),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Expanded(
              child: Image(
                image: getImageProvider(run.image ??
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Error.svg/2198px-Error.svg.png"),
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
}

class _ItemRunInfo extends StatelessWidget {
  final String title;
  final String content;

  const _ItemRunInfo({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class _Title extends StatelessWidget {
  final ImageProvider<Object>? avatar;
  final String? username;
  final DateTime timeStart;
  final String location;
  final VoidCallback onMenuClick;
  const _Title({
    Key? key,
    required this.avatar,
    required this.username,
    required this.timeStart,
    required this.location,
    required this.onMenuClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                "${formatTime(timeStart)} - $location",
                style: AppStyles.h6.copyWith(color: Colors.black),
                maxLines: 2,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onMenuClick,
          child: const Icon(
            Icons.more_horiz,
          ),
        ),
      ],
    );
  }
}
