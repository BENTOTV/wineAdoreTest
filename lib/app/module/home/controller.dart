import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/app/data/models/task.dart';
import 'package:test_flutter/app/data/services/storage/repository.dart';

class HomePageController extends GetxController {
  RepositoryTask repositoryTask;
  HomePageController({required this.repositoryTask});
  final formKey = GlobalKey<FormState>();
  final tasks = <Task>[].obs;
  final editCtlr = TextEditingController();
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final chipIndex = 0.obs;
  final tabIndex = 0.obs;
  final doingTask = <dynamic>[].obs;
  final doneTask = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(repositoryTask.readTasks());
    ever(tasks, (_) => repositoryTask.writeTasks(tasks));
  }

  @override
  void onClose() {
    editCtlr.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }

  void changeTask(List<dynamic> select) {
    doingTask.clear();
    doneTask.clear();
    for (int i = 0; i < select.length; i++) {
      {
        var task = select[i];
        var status = task['done'];
        if (status == true) {
          doneTask.add(task);
        } else {
          doingTask.add(task);
        }
      }
    }
  }

  int getTotalTask() {
    var res = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].tasks != null) {
        res += tasks[i].tasks!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    var res = 0;
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].tasks != null) {
        for (var j = 0; j < tasks[i].tasks!.length; j++) {
          if (tasks[i].tasks![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void setTask(Task? taski) {
    task.value = taski;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title) {
    var todos = task.tasks ?? [];
    if (todos.contains(title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.CopyWith(tasks: todos);
    int oldinx = tasks.indexOf(task);
    tasks[oldinx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containsTask(List task, String title) {
    return task.any((element) => element['title'] == title);
  }

  bool addDetailTask(String title) {
    var task = {'title': title, 'done': false};
    if (doingTask.any((element) => mapEquals<String, dynamic>(task, element))) {
      return false;
    }
    var donetask = {'title': title, 'done': true};
    if (doneTask
        .any((element) => mapEquals<String, dynamic>(donetask, element))) {
      return false;
    }
    doingTask.add(task);
    return true;
  }

  void updateDetailTask() {
    var newTasks = <Map<String, dynamic>>[];
    newTasks.addAll([...doingTask, ...doneTask]);
    var newTodo = task.value!.CopyWith(tasks: newTasks);
    int oldinx = tasks.indexOf(task.value!);
    tasks[oldinx] = newTodo;
    tasks.refresh();
  }

  void donetodo(String title) {
    var doingtask = {'title': title, 'done': false};
    int index =
        doingTask.indexWhere((element) => mapEquals(doingtask, element));
    doingTask.removeAt(index);
    var donetask = {'title': title, 'done': true};
    doneTask.add(donetask);
    doingTask.refresh();
    doneTask.refresh();
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  bool isTaskEmpty(Task task) {
    return task.tasks == null || task.tasks!.isEmpty;
  }

  int getDoneTask(Task task) {
    var res = 0;
    for (var i = 0; i < task.tasks!.length; i++) {
      if (task.tasks![i]['done'] == true) {
        res += 1;
      }
    }
    return res;
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTask
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTask.removeAt(index);
    doneTask.refresh();
  }
}
