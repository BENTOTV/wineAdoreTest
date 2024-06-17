import 'dart:convert';

import 'package:test_flutter/app/core/utils/keys.dart';
import 'package:test_flutter/app/data/models/task.dart';
import 'package:test_flutter/app/data/services/storage/service.dart';

class TaskProviders {
  final _storageService = StorageService();

  List<Task> getTasks() {
    var tasks = <Task>[];
    jsonDecode(_storageService.read(taskKey).toString()).forEach((e) {
      tasks.add(Task.fromJson(e));
    });
    return tasks;
  }

  void addTask(List<Task> task) {
    _storageService.write(taskKey, jsonEncode(task));
  }
}
