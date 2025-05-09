import 'package:devoida_front/core/utils/helpers/spacing.dart';
import 'package:devoida_front/core/utils/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/theming/styles.dart';
import '../../../home/presentation/view/model.dart';

class BoardTasks extends StatefulWidget {
  const BoardTasks({super.key});

  @override
  State<BoardTasks> createState() => _BoardTasksState();
}

class _BoardTasksState extends State<BoardTasks> {
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
      backgroundColor: Colors.pink,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.xmark),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pet-Yard",
              style: Styles.titleStyle.copyWith(color: Colors.white),
            ),
            Text("Trello workspace", style: Styles.subTitleStyle),
          ],
        ),
        backgroundColor: Colors.black.withOpacity(0.3),
      ),
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
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightSizedBox(8),
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
                          height: 120.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: column.tasks.length,
                            itemBuilder: (context, index) {
                              final task = column.tasks[index];
                              return Draggable<Task>(
                                data: task,
                                feedback: Material(
                                  child: Card(
                                    color: kPrimaryBlue,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0.h),
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
      width: 180.w,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 3,
        child: Center(
          child: Text(task.title, style: Styles.cardTitleStyle,),
        ),
      ),
    );
  }
}
