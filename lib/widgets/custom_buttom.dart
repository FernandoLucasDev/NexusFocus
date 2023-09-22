import 'package:flutter/material.dart';
import 'package:nexus_focus/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final background;
  final textColor;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.text,
    required this.background,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17,
              color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: background,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: textColor))),
      ),
    );
  }
}