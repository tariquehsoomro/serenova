import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ToDoListButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  
  ToDoListButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.yellow[500],
      child: Text(text),
    );
  }
}