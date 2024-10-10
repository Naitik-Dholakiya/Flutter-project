import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> tasks = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-Do List'),
        ),
        body: _selectedIndex == 0
            ? TaskList(
          tasks: tasks,
          toggleComplete: _toggleComplete,
        )
            : AddTaskForm(onAddTask: _addTask),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'To-Do List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Task',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  // Add task to the list
  void _addTask(String title, String description) {
    setState(() {
      tasks.add({
        'title': title,
        'description': description,
        'completed': false,
      });
    });
  }

  // Toggle task completion
  void _toggleComplete(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }
}

class TaskList extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final Function(int) toggleComplete;

  TaskList({required this.tasks, required this.toggleComplete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              tasks[index]['title'],
              style: TextStyle(
                decoration: tasks[index]['completed']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(tasks[index]['description']),
            trailing: IconButton(
              icon: Icon(
                tasks[index]['completed'] ? Icons.check_box : Icons.check_box_outline_blank,
                color: tasks[index]['completed'] ? Colors.green : null,
              ),
              onPressed: () => toggleComplete(index),
            ),
          ),
        );
      },
    );
  }
}

class AddTaskForm extends StatefulWidget {
  final Function(String, String) onAddTask;

  AddTaskForm({required this.onAddTask});

  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Task Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Task Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onAddTask(_title, _description);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task Added')),
                  );
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
