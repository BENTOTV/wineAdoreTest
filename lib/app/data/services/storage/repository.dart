import 'package:test_flutter/app/data/models/task.dart';
import 'package:test_flutter/app/data/providers/tasks/provider.dart';

class RepositoryTask {
  TaskProviders taskProviders;
  RepositoryTask({required this.taskProviders});

  List<Task> readTasks() => taskProviders.getTasks();
  void writeTasks(List<Task> tasks) => taskProviders.addTask(tasks);
}
