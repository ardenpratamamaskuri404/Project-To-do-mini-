import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;
  List<Todo> get doneTodos => _todos.where((t) => t.isDone).toList();

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    _todos.add(Todo(title: title));
    notifyListeners();
  }

  void toggleTodo(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void clearAll() {
    _todos.clear();
    notifyListeners();
  }

  void clearDone() {
    _todos.removeWhere((t) => t.isDone);
    notifyListeners();
  }
}
