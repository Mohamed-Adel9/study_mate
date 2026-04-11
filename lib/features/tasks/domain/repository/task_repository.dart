
import '../../data/model/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks();
  Future<void> addTasks(List<TaskModel> tasks);
  Future<void> removeTaskById(String id);
  Future<void> removeAllTasks();
}