import 'package:flutter/material.dart';

import 'model.dart';

class KanbanBoardSimple extends StatefulWidget {
  @override
  _KanbanBoardSimpleState createState() => _KanbanBoardSimpleState();
}

class _KanbanBoardSimpleState extends State<KanbanBoardSimple> {
  List<KanbanColumn> columns = [
    KanbanColumn(
      id: 'todo',
      title: 'To Do',
      tasks: [
        Task(id: '1', title: 'Task 1'),
        Task(id: '2', title: 'Task 2'),
        Task(id: '6', title: 'Task 6'),
        Task(id: '7', title: 'Task 7'),
      ],
    ),
    KanbanColumn(
      id: 'inprogress',
      title: 'In Progress',
      tasks: [Task(id: '3', title: 'Task 3')],
    ),
    KanbanColumn(
      id: 'done',
      title: 'Done',
      tasks: [Task(id: '4', title: 'Task 4')],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kanban Board")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children:
              columns.map((column) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      column.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DragTarget<Task>(
                      onWillAccept: (_) => true,
                      onAccept: (task) {
                        setState(() {
                          for (var col in columns) {
                            col.tasks.removeWhere((t) => t.id == task.id);
                          }
                          column.tasks.add(task);
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: column.tasks.length,
                            itemBuilder: (context, index) {
                              final task = column.tasks[index];
                              return Draggable<Task>(
                                data: task,
                                feedback: Material(
                                  child: Card(
                                    color: Colors.blueAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        task.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.5,
                                  child: _buildTaskCard(task),
                                ),
                                child: _buildTaskCard(task),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(task.title),
        ),
      ),
    );
  }
}
