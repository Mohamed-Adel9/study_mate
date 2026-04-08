import '../../domain/repository/subject_repository.dart';
import '../data_source/subject_local_data_source.dart';
import '../model/subject_model.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectLocalDataSource localDataSource;

  SubjectRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addSubjects(List<SubjectModel> subjects) async {
    await localDataSource.cacheSubjects(subjects);
  }

  @override
  Future<List<SubjectModel>> getSubjects() async {
    return await localDataSource.getCachedSubjects();
  }

  @override
  Future<void> removeSubjectById(String id) async {
    await localDataSource.deleteSubjectById(id);
  }

  @override
  Future<void> removeAllSubjects() async {
    await localDataSource.deleteAllSubjects();
  }
}