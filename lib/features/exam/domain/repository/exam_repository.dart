
import '../../data/model/exam_model.dart';

abstract class ExamRepository {
  Future<List<ExamModel>> getExams();
  Future<void> addExams(List<ExamModel> subjects);
  Future<void> removeExamById(String id);
  Future<void> removeAllExams();
}