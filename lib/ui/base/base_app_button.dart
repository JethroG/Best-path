import 'package:flutter/material.dart';

class BaseAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;

  const BaseAppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ??
                Theme.of(context)
                    .primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          child: Text(
            text,
            style: textStyle ?? const TextStyle(fontSize: 16.0,color: Colors.white),
          ),
        ));
  }
}
