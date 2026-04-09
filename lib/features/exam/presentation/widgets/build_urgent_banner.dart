import 'package:flutter/material.dart';
import 'package:study_mate/features/exam/data/model/exam_model.dart';

import '../../../../core/utils/exam_helper.dart';

Widget buildUrgentBanner(List<ExamModel> exams) {
  final urgentExams =
  exams.where((e) => isUrgent(e.date)).toList();

  if (urgentExams.isEmpty) return const SizedBox();

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
            "تنبيه عاجل\nلديك امتحانات خلال ${exams[0].date.day- DateTime.now().day} أيام، ابدأ المراجعة الآن",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}