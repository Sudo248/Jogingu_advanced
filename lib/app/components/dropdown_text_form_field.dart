import 'package:flutter/material.dart';

class DropdownTextFormField extends StatefulWidget {
  const DropdownTextFormField({
    required this.formKey,
    required this.items,
    required this.controller,
    this.labelText,
    this.hintText,
    this.icon,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.itemStyle,
    this.height,
    this.width,
    this.borderColor,
    this.labelColor,
    this.hintColor,
    this.focusColor,
    this.color,
    this.borderRadius = 8.0,
    this.dropdownColor,
    this.errorColor,
    this.enableColor,
    this.contentPadding,
    this.duration,
    this.heightExpand,
    this.onChange,
    this.onStateChange,
    this.onTap,
    this.validator,
  }) : super(key: null);

  final Key? formKey;
  final List<String> items;
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? itemStyle;
  final double? height, width, borderRadius;
  final Color? color;
  final Color? borderColor;
  final Color? enableColor;
  final Color? errorColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? dropdownColor;
  final Color? focusColor;
  final void Function(String value)? onChange;
  final void Function(bool isShow)? onStateChange;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback? onTap;
  final Duration? duration;
  final double? heightExpand;
  final String? Function(String?)? validator;

  @override
  State<DropdownTextFormField> createState() => _DropdownTextFormFieldState();
}

class _DropdownTextFormFieldState extends State<DropdownTextFormField>
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
      duration: widget.duration ?? const Duration(milliseconds: 500),
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
    final ThemeData themData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          boxShadow: [
            BoxShadow(
              blurRadius: widget.borderRadius!,
              color: Colors.grey.withOpacity(0.08),
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: Column(
          children: [
            Form(
              key: widget.formKey,
              child: TextFormField(
                controller: widget.controller,
                readOnly: true,
                validator: widget.validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: () {
                  widget.onTap?.call();
                  setState(() {
                    isShow = !isShow;
                    _runExpandCheck();
                  });
                },
                decoration: InputDecoration(
                  fillColor: widget.color ?? Colors.white,
                  filled: true,
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  labelStyle: widget.labelStyle ??
                      TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: widget.labelColor,
                      ),
                  floatingLabelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: widget.labelColor ?? themData.primaryColor,
                  ),
                  hintStyle: widget.hintStyle ??
                      TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: widget.hintColor ?? themData.hintColor,
                      ),
                  errorStyle: widget.errorStyle ??
                      TextStyle(
                        fontSize: 12.0,
                        color: widget.errorColor ?? themData.errorColor,
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius!),
                    borderSide: BorderSide(
                      color: widget.borderColor ?? themData.primaryColor,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius!),
                    borderSide: BorderSide(
                      color: widget.errorColor ?? themData.errorColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius!),
                    borderSide: BorderSide(
                      color: widget.focusColor ?? themData.focusColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius!),
                    borderSide: BorderSide(
                      color: widget.focusColor ?? themData.focusColor,
                    ),
                  ),
                  suffixIcon: RotationTransition(
                    turns: rotateAnimation,
                    child: widget.icon ?? Icon(Icons.arrow_drop_down, color: themData.iconTheme.color,),
                  ),
                ),
              ),
            ),
            SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: expandAnimation,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: widget.height ?? 45,
                  maxHeight: widget.heightExpand ?? 200,
                ),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(widget.borderRadius ?? 0),
                    bottomRight: Radius.circular(widget.borderRadius ?? 0),
                  ),
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
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final value = widget.items[index];
                    return InkWell(
                      onTap: () {
                        widget.onChange?.call(value);
                        setState(() {
                          widget.controller.text = widget.items[index];
                          isShow = false;
                          animationController.reverse();
                        });
                      },
                      child: Padding(
                        padding:
                            widget.contentPadding ?? const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          style: widget.itemStyle ?? widget.textStyle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
