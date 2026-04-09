import 'package:hive/hive.dart';

import '../model/exam_model.dart';

abstract class ExamLocalDataSource {
  Future<void> cacheExams(List<ExamModel> subjects);
  Future<void> deleteExamById(String id);
  Future<void> deleteAllExams();
  Future<List<ExamModel>> getCachedExams();
}

class ExamLocalDataSourceImpl implements ExamLocalDataSource {
  final String boxName = "Exams_box";

  /// Cache all subjects
  @override
  Future<void> cacheExams(List<ExamModel> subjects) async {
    final box = await Hive.openBox(boxName);
    final jsonList = subjects.map((e) => e.toJson()).toList();
    await box.put("Exams", jsonList);
  }

  /// Get all cached subjects
  @override
  Future<List<ExamModel>> getCachedExams() async {
    final box = await Hive.openBox(boxName);
    final data = box.get("Exams");

    if (data == null) return [];

    return (data as List)
        .map((e) => ExamModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// Delete a specific subject by its id
  @override
  Future<void> deleteExamById(String id) async {
    final box = await Hive.openBox(boxName);
    final data = box.get("Exams");

    if (data != null) {
      final updatedList = (data as List)
          .map((e) => ExamModel.fromJson(Map<String, dynamic>.from(e)))
          .where((subject) => subject.id != id)
          .map((subject) => subject.toJson())
          .toList();

      await box.put("Exams", updatedList);
    }
  }

  /// Delete all subjects
  @override
  Future<void> deleteAllExams() async {
    final box = await Hive.openBox(boxName);
    await box.delete("Exams");
  }
}