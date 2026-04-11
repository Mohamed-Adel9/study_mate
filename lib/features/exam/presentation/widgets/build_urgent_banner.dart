import 'package:flutter/material.dart';

import '../../../../core/utils/exam_helper.dart';
import '../../data/model/exam_model.dart';

Widget buildUrgentBanner(List<ExamModel> exams) {
  final now = DateTime.now();

  /// 1. Filter exams (not done + future)
  final upcomingExams = exams
      .where((e) => !e.isDone && e.date.isAfter(now))
      .toList();

  if (upcomingExams.isEmpty) return const SizedBox();

  /// 2. Sort by nearest date
  upcomingExams.sort((a, b) => a.date.compareTo(b.date));

  /// 3. Get nearest exam
  final nearestExam = upcomingExams.first;

  /// 4. Calculate days remaining
  final daysRemaining =
      nearestExam.date.difference(now).inDays;

  /// 5. Check if urgent (optional)
  if (!isUrgent(nearestExam.date)) return const SizedBox();

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.red),
    ),
    child: Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.red),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "تنبيه عاجل\nلديك امتحان خلال ${daysRemaining+1} يوم، ابدأ المراجعة الآن",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}