import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  const FieldWidget({
    Key? key,
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.filledColor,
    this.border, this.controller, this.hint, this.maxLines,
  }) : super(key: key);
  final Widget? prefix;
  final Widget? suffix;
  final bool obscure;
  final String? hint;
  final Color? filledColor;
  final int? maxLines;
  final OutlineInputBorder? border;
  final TextEditingController? controller;

  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscure,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
        suffixIcon: widget.suffix,
        contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
        filled: true,
        fillColor: widget.filledColor ?? Colors.grey.shade100,
        focusedBorder: widget.border ?? border,
        border: widget.border ?? border,
        focusedErrorBorder: widget.border ?? border,
        enabledBorder: widget.border ?? border,
        errorBorder: widget.border ?? border,
        disabledBorder: widget.border ?? border,
      ),
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(3),
    borderSide: const BorderSide(color: Colors.transparent, width: 0),
  );
}
