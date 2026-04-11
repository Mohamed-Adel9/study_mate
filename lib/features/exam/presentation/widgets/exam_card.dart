import 'package:flutter/material.dart';
import '../../../../core/utils/exam_helper.dart';

Widget examCard(dynamic exam,bool isDone) {
  final days = getDaysLeft(exam.date);
  final urgent = isUrgent(exam.date);

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: urgent && !isDone ? Border.all(color: Colors.red) : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
        ),
      ],
    ),
    child: Row(
      children: [

        /// Icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: urgent && !isDone ? Colors.red : Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.calendar_month_outlined, color: Colors.white),
        ),

        const SizedBox(width: 12),

        /// Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.subjectName,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(exam.date.toString().substring(0, 10)),

              if(isDone)
                const Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 14),
                    SizedBox(width: 4),
                    Text("تم", style: TextStyle(color: Colors.green)),
                  ],
                ),
              if (urgent && !isDone)
                const Row(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 14),
                    SizedBox(width: 4),
                    Text("عاجل", style: TextStyle(color: Colors.red)),
                  ],
                ),
            ],
          ),
        ),

        /// Days
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isDone ? Text(
        "Done",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: urgent ? Colors.green : Colors.black,
          ),
        ):Text(
              "${days+1}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: urgent ? Colors.red : Colors.black,
              ),
            ),
            isDone? Text("اضغط مطولا للحذف"): Text("يوم"),
          ],
        )
      ],
    ),
  );
}