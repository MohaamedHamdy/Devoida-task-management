class Task {
  final String id;
  final String title;

  Task({required this.id, required this.title});
}

class KanbanColumn {
  final String id;
  final String title;
  List<Task> tasks;

  KanbanColumn({required this.id, required this.title, required this.tasks});
}
