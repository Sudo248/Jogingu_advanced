import 'package:flutter/material.dart';
import 'package:jogingu_advanced/resources/app_colors.dart';
import 'package:jogingu_advanced/resources/app_styles.dart';

class BottomNavigationAppBar extends StatefulWidget {
  final List<ItemBottomAppBar> items;
  final ValueChanged<int>? onTapItem;
  final Color? backgroundColor;
  final Color? isSelectedItemColor;
  final Color? unisSelectedItemColor;
  final bool showUnisSelectedLabels;
  final double isSelectedFontSize;
  final double unisSelectedFontSize;
  final double? iconSize;
  final NotchedShape? shape;
  final double notchMargin;
  final double? height;
  final double? elevation;

  int currentIndex = 0;

  BottomNavigationAppBar(
      {Key? key,
      required this.items,
      this.onTapItem,
      this.backgroundColor,
      this.isSelectedItemColor = AppColors.primaryColor,
      this.unisSelectedItemColor = Colors.black54,
      this.showUnisSelectedLabels = true,
      this.isSelectedFontSize = 16.0,
      this.unisSelectedFontSize = 14.0,
      this.shape,
      this.notchMargin = 4,
	  this.elevation,
      this.height,
      this.iconSize})
      : super(key: key);

  @override
  State<BottomNavigationAppBar> createState() => _BottomNavigationAppBarState();
}

class _BottomNavigationAppBarState extends State<BottomNavigationAppBar> {
  final placeHolder = const Opacity(
    opacity: 0,
    child: IconButton(
      icon: Icon(
        Icons.no_cell,
      ),
      onPressed: null,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: widget.notchMargin,
	  elevation: widget.elevation,
      color: widget.backgroundColor ?? Colors.white,
      child: SizedBox(
        height: widget.height,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItem(0),
              _buildItem(1),
              placeHolder,
              _buildItem(2),
              _buildItem(3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    final item = widget.items[index];
    final isSelected = widget.currentIndex == index;
    final label = Text(
      item.label ?? "",
      style: TextStyle(
        fontFamily: FontFamily.raleway,
        fontWeight: FontWeight.normal,
        color: isSelected
            ? widget.isSelectedItemColor
            : widget.unisSelectedItemColor,
        fontSize: isSelected
            ? widget.isSelectedFontSize
            : widget.unisSelectedFontSize,
      ),
    );
    return MaterialButton(
      shape: const CircleBorder(),
      onPressed: () {
        if (widget.currentIndex == index) {
          return;
        }
        widget.onTapItem?.call(index);
        if (index != 3) {
          setState(() {
            widget.currentIndex = index;
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(
                color: isSelected
                    ? widget.isSelectedItemColor
                    : widget.unisSelectedItemColor,
                size: widget.iconSize),
            child: item.icon,
          ),
          isSelected
              ? label
              : widget.showUnisSelectedLabels
                  ? label
                  : const SizedBox()
        ],
      ),
    );
  }
}

class ItemBottomAppBar {
  final Widget icon;
  final String? label;
  const ItemBottomAppBar({required this.icon, this.label});
}


// class ItemBottomNavigationAppBar extends StatefulWidget {
//   final ItemBottomAppBar item;
//   final Color? isSelectedItemColor;
//   final Color? unisSelectedItemColor;
//   final bool showUnisSelectedLabels;
//   final double isSelectedFontSize;
//   final double unisSelectedFontSize;
//   final double? iconSize;

//   bool isSelected;

//   ItemBottomNavigationAppBar(
//       {Key? key,
//       required this.item,
//       this.isSelectedItemColor,
//       this.unisSelectedItemColor,
//       this.showUnisSelectedLabels = true,
//       this.isSelectedFontSize = 14.0,
//       this.unisSelectedFontSize = 12.0,
//       this.iconSize,
// 	  this.isSelected = false})
//       : super(key: key);

// 	 late _ItemBottomNavigationAppBarState _itemBottomNavigationAppBarState;

// 	 void onChangeState(bool isSelected){

// 	 }

//   @override
//   State<ItemBottomNavigationAppBar> createState(){
// 	  _itemBottomNavigationAppBarState = _ItemBottomNavigationAppBarState();
// 	  return _itemBottomNavigationAppBarState;
//   }
// }

// class _ItemBottomNavigationAppBarState
//     extends State<ItemBottomNavigationAppBar> {
//   @override
//   Widget build(BuildContext context) {
// 	  final label = Text(
//                   widget.item.label ?? "",
//                   style: TextStyle(
//         fontFamily: FontFamily.raleway,
//         color: widget.isSelected ? widget.isSelectedItemColor : widget.unisSelectedItemColor,
//         fontSize: widget.isSelected ? widget.isSelectedFontSize : widget.unisSelectedFontSize),
//                 );
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           IconTheme(
//             data: IconThemeData(
//                 color: widget.isSelected
//                     ? widget.isSelectedItemColor
//                     : widget.unisSelectedItemColor,
//                 size: widget.iconSize),
//             child: widget.item.icon,
//           ),
//           widget.isSelected
//               ? label
//               : widget.showUnisSelectedLabels
//                   ? label
//                   : const SizedBox()
//         ],
//       );
//   }
// }

