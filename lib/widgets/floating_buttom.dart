import 'dart:math';
import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:nexus_focus/utils/colors.dart';

class CircularMenuBtn extends StatelessWidget {
  final VoidCallback onPressed;

  CircularMenuBtn({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: CircularMenu(
        alignment: Alignment.bottomRight,
        toggleButtonColor: primaryColor,
        animationDuration: Duration(milliseconds: 800),
        curve: Curves.bounceOut,
        reverseCurve: Curves.fastOutSlowIn,
        toggleButtonBoxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 6,
          ),
        ],
        items: [
          CircularMenuItem(
            icon: Icons.more_time,
            color: primaryColor,
            onTap: () {
              print('Soy Yo!');
            },
          ),
          CircularMenuItem(
            icon: Icons.add_task,
            color: primaryColor,
            onTap: () {
              print('Soy Yo!');
            },
          ),
          CircularMenuItem(
            icon: Icons.sunny,
            color: primaryColor,
            onTap: () {
              print('Soy Yo!');
            },
          ),
        ],
      ),
    );
  }
}
