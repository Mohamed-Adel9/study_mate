
import '../repository/exam_repository.dart';

class DeleteExamsUseCase {
  final ExamRepository repository;

  DeleteExamsUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.removeExamById(id);
  }
}