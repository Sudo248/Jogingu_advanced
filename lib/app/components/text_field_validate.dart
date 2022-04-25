import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldValidate extends StatefulWidget {
  const TextFieldValidate({
    required this.formKey,
    required this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.onTextChange,
    this.validator,
    this.textInputAction,
    this.isPassword = false,
    this.textStyle,
    this.color,
    this.enableColor,
    this.forcusColor,
    this.errorColor,
    this.hintColor,
    this.labelColor,
    this.cursorColor,
    this.preffix,
    this.suffix,
    this.inputFormatters,
    this.onButtonFormChange,
	this.onTap,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.borderRadius = 15.0,
    this.width,
    this.height,
  }) : super(key: null);

  final Key? formKey;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onTextChange;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;
  final bool isPassword;
  final double? height, width, borderRadius;
  final Color? color;
  final Color? enableColor;
  final Color? forcusColor;
  final Color? errorColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? cursorColor;
  final Widget? suffix;
  final Widget? preffix;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final VoidCallback? onButtonFormChange;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextFieldValidate> createState() => _PillTextFeildState();
}

class _PillTextFeildState extends State<TextFieldValidate> {
  bool _showPassword = false;

  Widget _getPasswordButton() {
    if (!widget.isPassword) return const SizedBox.shrink();
    return IconButton(
      onPressed: () => setState(() {
        _showPassword = !_showPassword;
      }),
      icon: Icon(
        _showPassword
            ? Icons.visibility_off_outlined
            : Icons.remove_red_eye_outlined,
      ),
    );
  }

  Widget _getSuffix() {
    if (!widget.isPassword && widget.suffix == null) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.suffix ?? const SizedBox.shrink(),
        _getPasswordButton(),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }

  Widget _getPreffix() {
    if (widget.preffix == null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.suffix!,
        const SizedBox(
          width: 5,
        )
      ],
    );
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
        child: Form(
          key: widget.formKey,
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onTextChange,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            obscureText: widget.isPassword && !_showPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: widget.cursorColor ?? themData.primaryColor,
			onTap: widget.onTap,
			style: widget.textStyle,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              labelText: widget.labelText,
              hintText: widget.hintText,
              labelStyle: widget.labelStyle ??
                  TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: widget.labelColor ?? themData.primaryColor,
                  ),
              floatingLabelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
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
                  color: widget.color ?? themData.primaryColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                borderSide: BorderSide(
                  color: widget.errorColor ?? themData.errorColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                borderSide: BorderSide(
                  color: widget.forcusColor ?? themData.focusColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                borderSide: BorderSide(
                  color: widget.forcusColor ?? themData.focusColor,
                ),
              ),
              prefixIcon: _getPreffix(),
              suffixIcon: _getSuffix(),
            ),
          ),
        ),
      ),
    );
  }
}
