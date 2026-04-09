
import '../../domain/entity/exam_entity.dart';

class ExamModel extends ExamEntity {
  ExamModel({
    required super.id,
    required super.subjectId,
    required super.subjectName,
    required super.date,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
        id: json['id'],
        subjectId: json['subjectId'],
        subjectName: json['subjectName'],
        date: (json['date'])as DateTime,
    );
  }

  Map<String,dynamic>toJson(){
    return{
      "id":id,
      "subjectId":subjectId,
      "subjectName":subjectName,
      "date":date,

    };
  }
}
