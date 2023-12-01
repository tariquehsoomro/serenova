import 'package:flutter/material.dart';
import 'package:serenova/components/todo_list_button.dart';

// ignore: must_be_immutable
class ToDoListDialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  ToDoListDialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[400],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new task",
              ),
              // autofocus: true,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                // save button
                ToDoListButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 8),

                // cancel button
                ToDoListButton(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}