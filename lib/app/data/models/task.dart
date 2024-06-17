import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? tasks;

  Task(
      {required this.title,
      required this.icon,
      required this.color,
      this.tasks});

  Task CopyWith(
          {String? title,
          String? description,
          String? color,
          int? icon,
          List<dynamic>? tasks}) =>
      Task(
        title: title ?? this.title,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        tasks: tasks ?? this.tasks,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        color: json['color'],
        icon: json['icon'],
        tasks: json['tasks'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'color': color,
        'icon': icon,
        'tasks': tasks,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [title, icon, color];
}
