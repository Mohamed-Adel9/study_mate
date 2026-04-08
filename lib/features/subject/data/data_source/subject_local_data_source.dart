import 'package:hive/hive.dart';
import 'package:study_mate/features/subject/data/model/subject_model.dart';

abstract class SubjectLocalDataSource {
  Future<void> cacheSubjects(List<SubjectModel> subjects);
  Future<void> deleteSubjectById(String id);
  Future<void> deleteAllSubjects();
  Future<List<SubjectModel>> getCachedSubjects();
}

class SubjectLocalDataSourceImpl implements SubjectLocalDataSource {
  final String boxName = "Subjects_box";

  /// Cache all subjects
  @override
  Future<void> cacheSubjects(List<SubjectModel> subjects) async {
    final box = await Hive.openBox(boxName);
    final jsonList = subjects.map((e) => e.toJson()).toList();
    await box.put("Subjects", jsonList);
  }

  /// Get all cached subjects
  @override
  Future<List<SubjectModel>> getCachedSubjects() async {
    final box = await Hive.openBox(boxName);
    final data = box.get("Subjects");

    if (data == null) return [];

    return (data as List)
        .map((e) => SubjectModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// Delete a specific subject by its id
  @override
  Future<void> deleteSubjectById(String id) async {
    final box = await Hive.openBox(boxName);
    final data = box.get("Subjects");

    if (data != null) {
      final updatedList = (data as List)
          .map((e) => SubjectModel.fromJson(Map<String, dynamic>.from(e)))
          .where((subject) => subject.id != id)
          .map((subject) => subject.toJson())
          .toList();

      await box.put("Subjects", updatedList);
    }
  }

  /// Delete all subjects
  @override
  Future<void> deleteAllSubjects() async {
    final box = await Hive.openBox(boxName);
    await box.delete("Subjects");
  }
}