import 'package:study_mate/features/exam/data/model/exam_model.dart';

int getDaysLeft(DateTime date) {
  return date.difference(DateTime.now()).inDays;
}

List<ExamModel> getUrgentExams(List<ExamModel> exams) {
  final now = DateTime.now();
  return exams.where((exam) {
    final diff = exam.date.difference(now).inHours;
    return diff <= 48 && diff >= 0;
  }).toList();
}

bool isUrgent(DateTime date) {
  return getDaysLeft(date) <= 3;
}