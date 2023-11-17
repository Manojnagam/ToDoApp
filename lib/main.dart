import 'package:flutter/material.dart';

void main(){
  runApp(ToDoApp());
}
class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<String> _todoItems = [];

  void _addTodoItem(String item) {
    setState(() {
      _todoItems.add(item);
    });
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  Widget _buildToDoItem(String item, int index) {
    return Dismissible(
      key: Key(item),
      child: ListTile(
        title: Text(item),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeTodoItem(index),
        ),
      ),
      onDismissed: (direction) {
        _removeTodoItem(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task $item removed'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Enter a task'),
            onSubmitted: (text) {
              _addTodoItem(text);
              TextEditingController().clear(); // Clear the text field
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) =>
                  _buildToDoItem(_todoItems[index], index),
            ),
          ),
        ],
      ),
    );
  }
}
