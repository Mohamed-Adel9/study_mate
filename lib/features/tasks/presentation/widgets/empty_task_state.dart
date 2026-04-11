import 'package:flutter/material.dart';

class EmptyTasksWidget extends StatelessWidget {
  const EmptyTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "لا يوجد مهام، أضف مهام اليوم",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}