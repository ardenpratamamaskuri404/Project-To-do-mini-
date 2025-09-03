import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';
import 'done_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  int _selectedIndex = 0; // 0 = To-do, 1 = Done

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().todos;
    final todoProvider = context.read<TodoProvider>();

    Widget currentPage;
    if (_selectedIndex == 0) {
      // Halaman To-do
      currentPage = Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Tambahkan tugas...",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.edit),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      todoProvider.addTodo(_controller.text);
                      _controller.clear();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: todos.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "Belum ada tugas 🤔",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Text(
                          "Tambahkan tugas di atas ya!",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return TodoItem(index: index, todo: todos[index]);
                    },
                  ),
          ),
        ],
      );
    } else {
      // Halaman Done → langsung panggil DoneScreen
      currentPage = const DoneScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(_selectedIndex == 0 ? "📋 To-do List" : "✅ Tugas Selesai"),
        actions: [
          IconButton(
            tooltip: "Hapus Semua",
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            onPressed: () {
              if (_selectedIndex == 0) {
                todoProvider.clearAll();
              } else {
                todoProvider.clearDone();
              }
            },
          ),
        ],
      ),
      body: currentPage,
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  todoProvider.addTodo(_controller.text);
                  _controller.clear();
                }
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "To-do",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Selesai",
          ),
        ],
      ),
    );
  }
}
