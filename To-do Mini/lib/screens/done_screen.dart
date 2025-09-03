import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doneTodos = context.watch<TodoProvider>().doneTodos;

    if (doneTodos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Belum ada tugas yang selesai ✨",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: doneTodos.length,
      itemBuilder: (context, index) {
        final todo = doneTodos[index];
        return TodoItem(index: index, todo: todo);
      },
    );
  }
}
