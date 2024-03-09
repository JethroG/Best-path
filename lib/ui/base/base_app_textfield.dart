import 'package:flutter/material.dart';

class BaseTextEditor extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final int? maxLines;

  const BaseTextEditor({
    Key? key,
    this.hintText,
    this.controller,
    this.textStyle,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle ?? TextStyle(fontSize: 16.0),
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hintText,
        border: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
