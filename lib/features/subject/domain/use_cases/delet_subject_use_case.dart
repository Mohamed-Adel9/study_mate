
import '../repository/subject_repository.dart';

class DeleteSubjectsUseCase {
  final SubjectRepository repository;

  DeleteSubjectsUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.removeSubjectById(id);
  }
}