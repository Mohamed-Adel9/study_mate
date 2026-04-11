import '../../domain/repository/task_repository.dart';
import '../data_source/task_local_data_source.dart';
import '../model/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTasks(List<TaskModel> tasks) async {
    await localDataSource.cacheTasks(tasks);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return await localDataSource.getCachedTasks();
  }

  @override
  Future<void> removeTaskById(String id) async {
    await localDataSource.deleteTaskById(id);
  }

  @override
  Future<void> removeAllTasks() async {
    await localDataSource.deleteAllTasks();
  }
}