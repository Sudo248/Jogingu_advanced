import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget? child;
  final bool isActive;
  final Color? primary;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  late final ButtonStyle buttonStyle;
  final BorderRadius? borderRadius;
  final BorderSide? side;

  final Size? size;

  Button({
    Key? key,
    ButtonStyle? buttonStyle,
    this.child,
    this.isActive = true,
    this.primary,
    required this.onPressed,
    this.onLongPress,
    this.borderRadius,
    this.side,
	this.size,
  }) : super(key: key) {
    this.buttonStyle = buttonStyle ??
        ElevatedButton.styleFrom(
          primary: primary,
          shape: RoundedRectangleBorder(
            side: side ?? BorderSide.none,
            borderRadius: borderRadius ?? BorderRadius.zero,
          ),
          fixedSize: size,
        );
    // ButtonStyle(
    //   foregroundColor: MaterialStateProperty.resolveWith<Color?>(
    //     (Set<MaterialState> states) {
    //       if (states.contains(MaterialState.disabled)) {
    //         return colorInActive;
    //       }
    //       return colorActive;
    //     },
    //   ),
    //   backgroundColor:  MaterialStateProperty.resolveWith<Color?>(
    //     (Set<MaterialState> states) {
    //       if (states.contains(MaterialState.disabled)) {
    //         return colorInActive;
    //       }
    //       return colorActive;
    //     },
    //   ),
    //   shape: MaterialStateProperty.all<OutlinedBorder>(
    //     RoundedRectangleBorder(
    //       side: side ?? BorderSide.none,
    //       borderRadius: borderRadius ?? BorderRadius.zero,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? onPressed : null,
      onLongPress: onLongPress,
      style: buttonStyle,
      child: child,
    );
  }
}
