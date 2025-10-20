import 'package:flutter/material.dart';
import '../model/task.dart';
import '../utils/storage.dart';
import 'add_edit_task_screen.dart';
import '../widgets/task_card.dart';
import '../screens/setting_screen.dart'; 

class HomeScreen extends StatefulWidget {
  final List<Task> tasks;

  const HomeScreen({super.key, required this.tasks});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Task> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = widget.tasks;
  }

  void _toggleComplete(int index) async {
    setState(() {
      _tasks[index].completed = !_tasks[index].completed;
    });
    await TaskStorage.savetask(_tasks);
  }

  void _deletedTask(int index) async {
    setState(() {
      _tasks.removeAt(index);
    });
    await TaskStorage.savetask(_tasks);
  }

  Future<void> _navigateToAddTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (newTask != null) {
      setState(() {
        _tasks.add(newTask);
      });
      await TaskStorage.savetask(_tasks);
    }
  }

  // ✅ Navigate to Settings (wait for result)
  Future<void> _navigateToSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );

    // ✅ If tasks were cleared, reload them
    if (result == true) {
      final refreshedTasks = await TaskStorage.loadTasks();
      setState(() {
        _tasks = refreshedTasks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: _navigateToSettings,
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet — tap + to add one!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return TaskCard(
                  task: task,
                  onToggle: () => _toggleComplete(index),
                  onDelete: () => _deletedTask(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        tooltip: 'Add Task',
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
