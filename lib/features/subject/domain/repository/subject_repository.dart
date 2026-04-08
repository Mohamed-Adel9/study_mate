import '../../data/model/subject_model.dart';

abstract class SubjectRepository {
  Future<List<SubjectModel>> getSubjects();
  Future<void> addSubjects(List<SubjectModel> subjects);
  Future<void> removeSubjectById(String id);
  Future<void> removeAllSubjects();
}