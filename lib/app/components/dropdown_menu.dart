import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  DropdownMenu({
    Key? key,
    required this.buildItem,
    this.itemCount,
    this.hint,
    this.contentPadding,
    this.duration,
    this.onChange,
    this.onStateChange,
    this.onTap,
    this.selectedIndex,
    this.border,
    this.splashColor,
    this.splashItemColor,
    this.icon,
    this.color,
    this.dropdownColor,
    this.radius = const Radius.circular(10),
    this.width,
    this.height,
    this.heightExpand,
  }) : super(key: key);

  final int? itemCount;
  final Widget? icon;
  final Widget? hint;
  final Color? splashItemColor;
  final Color? splashColor;
  final Widget Function(BuildContext context, int index) buildItem;
  final void Function(int index)? onChange;
  final void Function(bool isShow)? onStateChange;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback? onTap;
  final Duration? duration;
  final Color? color;
  final Color? dropdownColor;
  final Border? border;
  int? selectedIndex;
  final Radius radius;
  final double? width;
  final double? height;
  final double? heightExpand;

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> expandAnimation;
  late final Animation<double> rotateAnimation;

  bool isShow = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 200),
    );
    expandAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    widget.onStateChange?.call(isShow);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color ?? Colors.white,
              border: widget.border,
              borderRadius: isShow
                  ? BorderRadius.only(
                      topLeft: widget.radius,
                      topRight: widget.radius,
                    )
                  : BorderRadius.all(widget.radius),
              boxShadow: isShow
                  ? []
                  : [
                      const BoxShadow(
                        blurRadius: 5,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      )
                    ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: widget.splashColor ?? Colors.grey.withOpacity(0.3),
                highlightColor: widget.splashColor?.withOpacity(0.8) ??
                    Colors.grey.withOpacity(0.2),
                onTap: () {
                  widget.onTap?.call();
                  setState(() {
                    isShow = !isShow;
                    _runExpandCheck();
                  });
                },
                child: Padding(
                  padding: widget.contentPadding ?? const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      widget.selectedIndex == null
                          ? widget.hint ?? const SizedBox.shrink()
                          : widget.buildItem(context, widget.selectedIndex!),
                      const Spacer(),
                      RotationTransition(
                        turns: rotateAnimation,
                        child: widget.icon ?? const Icon(Icons.arrow_drop_down),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: expandAnimation,
            child: Container(
              constraints: BoxConstraints(
                minHeight: widget.height ?? 40,
                maxHeight: widget.heightExpand ?? 200,
              ),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: widget.radius,
                  bottomRight: widget.radius,
                ),
                // border: widget.border,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  ),
                ],
                color: widget.dropdownColor ?? Colors.white,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.itemCount,
                itemBuilder: (context, index) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      widget.onChange?.call(index);
                      setState(() {
                        widget.selectedIndex = index;
                        isShow = false;
                        animationController.reverse();
                      });
                    },
                    splashColor:
                        widget.splashItemColor ?? Colors.grey.withOpacity(0.3),
                    highlightColor: widget.splashItemColor?.withOpacity(0.8) ??
                        Colors.grey.withOpacity(0.2),
                    // customBorder: const StadiumBorder(),
                    child: Padding(
                      padding:
                          widget.contentPadding ?? const EdgeInsets.all(8.0),
                      child: widget.buildItem(context, index),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
