import 'package:study_mate/features/subject/data/model/subject_model.dart';
import 'package:study_mate/features/subject/domain/repository/subject_repository.dart';

class AddSubjectsUseCase {
  final SubjectRepository repository;

  AddSubjectsUseCase(this.repository);

  Future<void> call(List<SubjectModel> subjects) async {
    await repository.addSubjects(subjects);
  }
}