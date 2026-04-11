
import '../../domain/entity/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.subjectId,
    required super.subjectName,
    required super.date,
    required super.isDone,
    required super.title,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        subjectId: json['subjectId'],
        subjectName: json['subjectName'],
        date: (json['date'])as DateTime,
        isDone: json['isDone'],
      title: json['title'],
    );
  }

  Map<String,dynamic>toJson(){
    return{
      "id":id,
      "subjectId":subjectId,
      "subjectName":subjectName,
      "date":date,
      "isDone":isDone,
      "title":title,

    };
  }

  TaskModel copyWith({
    String? id,
    String? subjectId,
    String? title,
    String? subjectName,
    DateTime? date,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      title: title ?? this.title,
    );
  }
}
