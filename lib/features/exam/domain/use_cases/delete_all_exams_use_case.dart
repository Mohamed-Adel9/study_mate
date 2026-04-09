
import '../repository/exam_repository.dart';

class DeleteAllExamsUseCase {
  final ExamRepository repository;

  DeleteAllExamsUseCase(this.repository);

  Future<void> call() async {
    await repository.removeAllExams();
  }
}