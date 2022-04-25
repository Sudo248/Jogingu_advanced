import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldNoneValidate extends StatefulWidget {
  const TextFieldNoneValidate({
    Key? key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.onTextChange,
    this.textInputAction,
    this.isPassword = false,
    this.color,
    this.enableColor,
    this.forcusColor,
    this.errorColor,
    this.hintColor,
    this.labelColor,
    this.cursorColor,
    this.preffix,
    this.suffix,
	this.textStyle,
    this.inputFormatters,
    this.borderRadius = 10.0,
    this.readOnly = false,
    this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final Function(String)? onTextChange;
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
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextFieldNoneValidate> createState() => _TextFieldNoneValidate();
}

class _TextFieldNoneValidate extends State<TextFieldNoneValidate> {
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
        child: TextFormField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          onChanged: widget.onTextChange,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.isPassword && !_showPassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: widget.cursorColor ?? themData.primaryColor,
		  style: widget.textStyle,
          onTap: widget.onTap,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: widget.labelColor,
            ),
            floatingLabelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: widget.labelColor ?? themData.primaryColor,
            ),
            hintStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: widget.hintColor ?? themData.hintColor,
            ),
            errorStyle: TextStyle(
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
    );
  }
}
