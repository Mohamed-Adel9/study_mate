
import '../../data/model/task_model.dart';
import '../repository/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call(List<TaskModel> tasks) async {
    await repository.addTasks(tasks);
  }
}