import 'package:study_mate/features/subject/data/model/subject_model.dart';
import 'package:study_mate/features/subject/domain/repository/subject_repository.dart';

class GetSubjectsUseCase {
  final SubjectRepository repository;

  GetSubjectsUseCase(this.repository);

  Future<List<SubjectModel>> call() async {
    return await repository.getSubjects();
  }
}