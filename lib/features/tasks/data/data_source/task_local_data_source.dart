import 'package:hive/hive.dart';

import '../model/task_model.dart';

abstract class TaskLocalDataSource {
  Future<void> cacheTasks(List<TaskModel> tasks);
  Future<void> deleteTaskById(String id);
  Future<void> deleteAllTasks();
  Future<List<TaskModel>> getCachedTasks();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final String boxName = "Tasks_box";

  /// Cache all tasks
  @override
  Future<void> cacheTasks(List<TaskModel> tasks) async {
    final box = await Hive.openBox(boxName);
    final jsonList = tasks.map((e) => e.toJson()).toList();
    await box.put("Tasks", jsonList);
  }

  /// Get all cached tasks
  @override
  Future<List<TaskModel>> getCachedTasks() async {
    final box = await Hive.openBox(boxName);
    final data = box.get("Tasks");

    if (data == null) return [];

    return (data as List)
        .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// Delete a specific subject by its id
  @override
  Future<void> deleteTaskById(String id) async {
    final box = await Hive.openBox(boxName);
    final data = box.get("Tasks");

    if (data != null) {
      final updatedList = (data as List)
          .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
          .where((subject) => subject.id != id)
          .map((subject) => subject.toJson())
          .toList();

      await box.put("Tasks", updatedList);
    }
  }

  /// Delete all tasks
  @override
  Future<void> deleteAllTasks() async {
    final box = await Hive.openBox(boxName);
    await box.delete("Tasks");
  }
}