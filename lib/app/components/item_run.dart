import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_assets.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class ItemRun extends StatelessWidget {
  final double height;
  const ItemRun({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            SizedBox(
              height: height / 40,
            ),
            Text(
              "Afternoon Run",
              style: AppStyles.h4
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height / 40,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _itemRunInfo("Distance", "5.03 km"),
                  const VerticalDivider(
                    thickness: 2,
                  ),
                  _itemRunInfo("Pace", "7:25 /km"),
                  const VerticalDivider(
                    thickness: 2,
                  ),
                  _itemRunInfo("Time", "37m 18s"),
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Expanded(
              child: Image.asset(
                AppAssets.avatar,
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(AppAssets.avatar),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sudo",
              style: AppStyles.h5.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Yesterday at 5:45 PM - Luong Ngoc Quyen, Ha Dong, Ha Noi",
              style: AppStyles.h6.copyWith(color: Colors.black),
            ),
          ],
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
