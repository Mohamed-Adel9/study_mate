import 'package:study_mate/features/exam/data/model/exam_model.dart';
import 'package:study_mate/features/subject/data/model/subject_model.dart';

import '../../../tasks/data/model/task_model.dart';

class HomeData {
  final List<SubjectModel> subjects;
  final List<TaskModel> todayTasks;
  final List<ExamModel> exams;
  final List<ExamModel> urgentExams;
  final int completedTasks;
  final int totalTasks;

  HomeData({
    required this.subjects,
    required this.exams,
    required this.urgentExams,
    required this.completedTasks,
    required this.totalTasks,
    required this.todayTasks,
  });
}