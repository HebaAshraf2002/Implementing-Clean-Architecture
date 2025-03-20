import 'package:clean_arcticture/domain/entities/task.dart';
import 'package:clean_arcticture/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks({required this.repository});

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
