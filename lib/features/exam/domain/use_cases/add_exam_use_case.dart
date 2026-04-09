
import '../../data/model/exam_model.dart';
import '../repository/exam_repository.dart';

class AddExamUseCase {
  final ExamRepository repository;

  AddExamUseCase(this.repository);

  Future<void> call(List<ExamModel> subjects) async {
    await repository.addExams(subjects);
  }
}