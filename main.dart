import 'package:flutter/material.dart';

void main() {
 runApp(MaterialApp(
    home: ToDo(),
 ));
}

class ToDo extends StatefulWidget {
 @override
 _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
 List<String> tasks = [];
 TextEditingController taskController = TextEditingController();

 void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text);
      });
      taskController.clear();
    }
 }

 void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                 child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(hintText: 'Enter task'),
                 ),
                ),
                IconButton(
                 icon: Icon(Icons.add),
                 onPressed: addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                 key: Key(tasks[index]),
                 background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                 ),
                 direction: DismissDirection.endToStart,
                 onDismissed: (direction) {
                    removeTask(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task removed')),
                    );
                 },
                 child: ListTile(
                    title: Text(tasks[index]),
                 ),
                );
              },
            ),
          ),
        ],
      ),
    );
 }
}
