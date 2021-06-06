import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.indigo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: new BoxConstraints(maxWidth: 450),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: textColor,
            primary: backgroundColor,
            minimumSize: Size(56, 56),
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
