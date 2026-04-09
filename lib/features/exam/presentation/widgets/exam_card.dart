import 'package:flutter/material.dart';
import '../../../../core/utils/exam_helper.dart';

Widget examCard(dynamic exam) {
  final days = getDaysLeft(exam.date);
  final urgent = isUrgent(exam.date);

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: urgent ? Border.all(color: Colors.red) : null,
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
            color: urgent ? Colors.red : Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.calendar_month, color: Colors.white),
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

              if (urgent)
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
          children: [
            Text(
              "${days+1}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: urgent ? Colors.red : Colors.black,
              ),
            ),
            const Text("يوم"),
          ],
        )
      ],
    ),
  );
}