import 'package:test/test.dart';
import 'package:test_flutter/app/data/models/task.dart';
// Adjust the import to your package

void main() {
  group('Task Model', () {
    test('Task object creation', () {
      final task = Task(
        title: 'Test Task',
        icon: 1,
        color: 'red',
        tasks: ['subtask1', 'subtask2'],
      );

      expect(task.title, 'Test Task');
      expect(task.icon, 1);
      expect(task.color, 'red');
      expect(task.tasks, ['subtask1', 'subtask2']);
    });

    test('CopyWith method', () {
      final task = Task(
        title: 'Test Task',
        icon: 1,
        color: 'red',
        tasks: ['subtask1', 'subtask2'],
      );

      final updatedTask = task.CopyWith(
        title: 'Updated Task',
        icon: 2,
        color: 'blue',
      );

      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.icon, 2);
      expect(updatedTask.color, 'blue');
      expect(updatedTask.tasks, ['subtask1', 'subtask2']);
    });

    test('toJson method', () {
      final task = Task(
        title: 'Test Task',
        icon: 1,
        color: 'red',
        tasks: ['subtask1', 'subtask2'],
      );

      final json = task.toJson();

      expect(json, {
        'title': 'Test Task',
        'icon': 1,
        'color': 'red',
        'tasks': ['subtask1', 'subtask2'],
      });
    });

    test('fromJson method', () {
      final json = {
        'title': 'Test Task',
        'icon': 1,
        'color': 'red',
        'tasks': ['subtask1', 'subtask2'],
      };

      final task = Task.fromJson(json);

      expect(task.title, 'Test Task');
      expect(task.icon, 1);
      expect(task.color, 'red');
      expect(task.tasks, ['subtask1', 'subtask2']);
    });

    test('Equatable props', () {
      final task1 = Task(
        title: 'Test Task',
        icon: 1,
        color: 'red',
      );

      final task2 = Task(
        title: 'Test Task',
        icon: 1,
        color: 'red',
      );

      final task3 = Task(
        title: 'Different Task',
        icon: 2,
        color: 'blue',
      );

      expect(task1 == task2, isTrue);
      expect(task1 == task3, isFalse);
    });
  });
}
