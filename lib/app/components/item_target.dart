import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class ItemTarget extends StatelessWidget {
  final String title;
  final ValueNotifier<String> contentValue;
  final VoidCallback? onClick;

  const ItemTarget({
    Key? key,
    required this.title,
    required this.contentValue,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyles.h4.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ValueListenableBuilder(
            valueListenable: contentValue,
            builder: (context, String value, child) {
              return Text(
                value,
                style: AppStyles.h4.copyWith(
                  color: AppColors.primaryColor,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
