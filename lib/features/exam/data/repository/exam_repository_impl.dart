import '../../domain/repository/exam_repository.dart';
import '../data_source/exam_local_data_source.dart';
import '../model/exam_model.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamLocalDataSource localDataSource;

  ExamRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addExams(List<ExamModel> subjects) async {
    await localDataSource.cacheExams(subjects);
  }

  @override
  Future<List<ExamModel>> getExams() async {
    return await localDataSource.getCachedExams();
  }

  @override
  Future<void> removeExamById(String id) async {
    await localDataSource.deleteExamById(id);
  }

  @override
  Future<void> removeAllExams() async {
    await localDataSource.deleteAllExams();
  }
}