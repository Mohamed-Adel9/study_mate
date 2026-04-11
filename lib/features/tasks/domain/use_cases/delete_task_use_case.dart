
import '../repository/task_repository.dart';

class DeleteTasksUseCase {
  final TaskRepository repository;

  DeleteTasksUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.removeTaskById(id);
  }
}