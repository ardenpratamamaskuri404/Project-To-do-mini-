import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final int index;
  final Todo todo;

  const TodoItem({super.key, required this.index, required this.todo});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 2,
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) => provider.toggleTodo(index),
          activeColor: Colors.green,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            color: todo.isDone ? Colors.grey : Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => provider.removeTodo(index),
        ),
      ),
    );
  }
}
