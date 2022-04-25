import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class ChooseDayMonth extends StatefulWidget {
  final Function(int) onItemClick;
  const ChooseDayMonth({Key? key, required this.onItemClick}) : super(key: key);

  @override
  State<ChooseDayMonth> createState() => _ChooseDayMonthState();
}

class _ChooseDayMonthState extends State<ChooseDayMonth> {
  int currentItem = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      //   mainAxisSize: MainAxisSize.min,
      children: [
        buildItem(0, "D"),
		buildItem(1, "W"),
        buildItem(2, "M"),
        const SizedBox(
          width: 24,
        ),
      ],
    );
  }

  Widget buildItem(int index, String title) {
    return InkWell(
      onTap: () {
        widget.onItemClick(index);
        setState(() {
          currentItem = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
		
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: currentItem == index ? AppColors.primaryColor : Colors.white,
        ),
        child: Text(
          title,
          style: AppStyles.h5.copyWith(
            color: currentItem == index ? Colors.white : AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
