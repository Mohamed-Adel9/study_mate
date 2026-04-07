import 'package:study_mate/features/subject/domain/entity/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  SubjectModel({
    required super.id,
    required super.name,
    required super.color,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
        id: json['id'],
        name: json['name'],
        color: json['color'],
    );
  }

  Map<String,dynamic>toJSon(){
    return{
      "id":id,
      "name":name,
      "color":color,
    };
  }
}
