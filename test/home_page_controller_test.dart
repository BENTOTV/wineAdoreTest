import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/app/data/models/task.dart';
import 'package:test_flutter/app/data/services/storage/repository.dart';

import 'package:test_flutter/app/module/home/controller.dart';

// Mock class for RepositoryTask
class MockRepositoryTask extends Mock implements RepositoryTask {}

void main() {
  group('HomePageController Tests', () {
    late HomePageController homePageController;
    late MockRepositoryTask mockRepositoryTask;

    setUp(() {
      mockRepositoryTask = MockRepositoryTask();
      homePageController =
          HomePageController(repositoryTask: mockRepositoryTask);
    });

    test('Initial values are correct', () {
      expect(homePageController.tasks, isEmpty);
      expect(homePageController.deleting.value, isFalse);
      expect(homePageController.task.value, isNull);
      expect(homePageController.chipIndex.value, 0);
      expect(homePageController.tabIndex.value, 0);
      expect(homePageController.doingTask, isEmpty);
      expect(homePageController.doneTask, isEmpty);
    });

    test('changeChipIndex updates chipIndex', () {
      homePageController.changeChipIndex(1);
      expect(homePageController.chipIndex.value, 1);
    });

    test('changeTask updates doingTask and doneTask', () {
      final select = [
        {'title': 'Task 1', 'done': false},
        {'title': 'Task 2', 'done': true}
      ];

      homePageController.changeTask(select);

      expect(homePageController.doingTask, [
        {'title': 'Task 1', 'done': false}
      ]);
      expect(homePageController.doneTask, [
        {'title': 'Task 2', 'done': true}
      ]);
    });

    test('getTotalTask returns correct total', () {
      homePageController.tasks.assignAll([
        Task(title: 'Task 1', icon: 1, color: 'red', tasks: [
          {'title': 'Subtask 1', 'done': false},
          {'title': 'Subtask 2', 'done': true}
        ]),
        Task(title: 'Task 2', icon: 2, color: 'blue')
      ]);

      expect(homePageController.getTotalTask(), 2);
    });

    test('getTotalDoneTask returns correct total done tasks', () {
      homePageController.tasks.assignAll([
        Task(title: 'Task 1', icon: 1, color: 'red', tasks: [
          {'title': 'Subtask 1', 'done': true},
          {'title': 'Subtask 2', 'done': true}
        ]),
        Task(title: 'Task 2', icon: 2, color: 'blue', tasks: [
          {'title': 'Subtask 3', 'done': false}
        ])
      ]);

      expect(homePageController.getTotalDoneTask(), 2);
    });

    test('changeDeleting updates deleting', () {
      homePageController.changeDeleting(true);
      expect(homePageController.deleting.value, isTrue);
    });

    test('changeTabIndex updates tabIndex', () {
      homePageController.changeTabIndex(1);
      expect(homePageController.tabIndex.value, 1);
    });

    test('setTask updates task', () {
      final task = Task(title: 'Task', icon: 1, color: 'red');
      homePageController.setTask(task);
      expect(homePageController.task.value, task);
    });

    test('deleteTask removes task from tasks', () {
      final task = Task(title: 'Task', icon: 1, color: 'red');
      homePageController.tasks.add(task);
      homePageController.deleteTask(task);
      expect(homePageController.tasks.contains(task), isFalse);
    });

    test('updateTask adds a new todo if not already present', () {
      final task = Task(title: 'Task', icon: 1, color: 'red', tasks: []);
      homePageController.tasks.add(task);
      final result = homePageController.updateTask(task, 'New Todo');
      expect(result, isTrue);
      expect(homePageController.tasks.first.tasks!.length, 1);
      expect(homePageController.tasks.first.tasks!.first['title'], 'New Todo');
    });

    test('addDetailTask returns false if task already exists', () {
      homePageController.doingTask.add({'title': 'New Task', 'done': false});
      final result = homePageController.addDetailTask('New Task');
      expect(result, isFalse);
    });

    test('addDetailTask returns true and adds task if it does not exist', () {
      final result = homePageController.addDetailTask('New Task');
      expect(result, isTrue);
      expect(homePageController.doingTask, [
        {'title': 'New Task', 'done': false}
      ]);
    });

    test('updateDetailTask updates task with new tasks', () {
      final task = Task(title: 'Task', icon: 1, color: 'red', tasks: []);
      homePageController.tasks.add(task);
      homePageController.setTask(task);
      homePageController.doingTask.add({'title': 'New Task', 'done': false});
      homePageController.updateDetailTask();
      expect(homePageController.tasks.first.tasks!.length, 1);
      expect(homePageController.tasks.first.tasks!.first['title'], 'New Task');
    });

    test('donetodo moves task from doingTask to doneTask', () {
      homePageController.doingTask.add({'title': 'New Task', 'done': false});
      homePageController.donetodo('New Task');
      expect(homePageController.doingTask, isEmpty);
      expect(homePageController.doneTask, [
        {'title': 'New Task', 'done': true}
      ]);
    });

    test('addTask returns false if task already exists', () {
      final task = Task(title: 'Task', icon: 1, color: 'red');
      homePageController.tasks.add(task);
      final result = homePageController.addTask(task);
      expect(result, isFalse);
    });

    test('addTask returns true and adds task if it does not exist', () {
      final task = Task(title: 'Task', icon: 1, color: 'red');
      final result = homePageController.addTask(task);
      expect(result, isTrue);
      expect(homePageController.tasks.contains(task), isTrue);
    });

    test('isTaskEmpty returns true if task has no subtasks', () {
      final task = Task(title: 'Task', icon: 1, color: 'red');
      expect(homePageController.isTaskEmpty(task), isTrue);
    });

    test('isTaskEmpty returns false if task has subtasks', () {
      final task = Task(title: 'Task', icon: 1, color: 'red', tasks: [
        {'title': 'Subtask', 'done': false}
      ]);
      expect(homePageController.isTaskEmpty(task), isFalse);
    });

    test('getDoneTask returns correct count of done subtasks', () {
      final task = Task(title: 'Task', icon: 1, color: 'red', tasks: [
        {'title': 'Subtask 1', 'done': true},
        {'title': 'Subtask 2', 'done': false}
      ]);
      expect(homePageController.getDoneTask(task), 1);
    });

    test('deleteDoneTodo removes task from doneTask', () {
      final doneTodo = {'title': 'New Task', 'done': true};
      homePageController.doneTask.add(doneTodo);
      homePageController.deleteDoneTodo(doneTodo);
      expect(homePageController.doneTask.contains(doneTodo), isFalse);
    });
  });
}
