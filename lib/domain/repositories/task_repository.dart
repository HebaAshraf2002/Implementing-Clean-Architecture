
import 'package:clean_arcticture/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
}
