import 'package:study_mate/features/subject/domain/repository/subject_repository.dart';

class DeleteAllSubjectsUseCase {
  final SubjectRepository repository;

  DeleteAllSubjectsUseCase(this.repository);

  Future<void> call() async {
    await repository.removeAllSubjects();
  }
}