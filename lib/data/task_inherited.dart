import 'package:alura_flutter_curso_1/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child,
  });
  final List<Tasks> taskList = [
    Tasks('Aprender Flutter', 'assets/dash.png', dificuldade: 3),
    Tasks('Andar de Bike', 'assets/bike.webp', dificuldade: 2),
    Tasks('Meditar', 'assets/meditar.jpeg', dificuldade: 5),
    Tasks('Ler', 'assets/livro.jpg', dificuldade: 4),
    Tasks('Jogar', 'assets/jogar.jpg', dificuldade: 1),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(
      Tasks(name, photo, dificuldade: difficulty),
    );
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
