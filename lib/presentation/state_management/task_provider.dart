import 'package:clean_arcticture/domain/entities/task.dart';
import 'package:clean_arcticture/domain/usecases/get_tasks.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final GetTasks getTasks;

  TaskProvider({required this.getTasks});

  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;

  bool get isLoading => _isLoading;

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    _tasks = await getTasks();

    _isLoading = false;
    notifyListeners();
  }
}
