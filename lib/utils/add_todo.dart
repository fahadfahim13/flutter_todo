import 'package:flutter/material.dart';
import 'package:todo/utils/button.dart';

class AddTodo extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  AddTodo({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a new task'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(onPressed: onSave, text: 'Add'),
                const SizedBox(
                  width: 8,
                ),
                Button(onPressed: onCancel, text: 'Cancel'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
