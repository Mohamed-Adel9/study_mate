
import '../../data/model/task_model.dart';
import '../repository/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<TaskModel>> call() async {
    return await repository.getTasks();
  }
}