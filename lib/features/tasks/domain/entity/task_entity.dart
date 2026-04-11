class TaskEntity {
  final String id;
  final String subjectId;
  final String title;
  final String subjectName;
  final DateTime date;
  final bool isDone;

  TaskEntity({
    required this.id,
    required this.title,
    required this.subjectId,
    required this.subjectName,
    required this.date,
    required this.isDone,
  });
}