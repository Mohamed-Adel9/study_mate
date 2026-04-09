
import '../../data/model/exam_model.dart';
import '../repository/exam_repository.dart';

class GetExamsUseCase {
  final ExamRepository repository;

  GetExamsUseCase(this.repository);

  Future<List<ExamModel>> call() async {
    return await repository.getExams();
  }
}