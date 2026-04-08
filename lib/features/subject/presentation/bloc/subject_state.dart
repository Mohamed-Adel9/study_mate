import 'dart:ui';

import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/features/subject/data/model/subject_model.dart';

abstract class SubjectState {
  final String name;
  final Color color;

  const SubjectState({
    this.name = '',
    this.color = AppColors.blue,
  });
}

class SubjectInit extends SubjectState {
  const SubjectInit();
}

class SubjectLoading extends SubjectState {
  const SubjectLoading({super.name, super.color});
}

class SubjectLoaded extends SubjectState {
  final List<SubjectModel> subjects;

  const SubjectLoaded(
    this.subjects, {
    String name = '',
    Color color = AppColors.blue,
  }) : super(name: name, color: color);

  /// Creates a copy with optional overrides — keeps list & form state together.
  SubjectLoaded copyWith({
    List<SubjectModel>? subjects,
    String? name,
    Color? color,
  }) {
    return SubjectLoaded(
      subjects ?? this.subjects,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}

class SubjectError extends SubjectState {
  final String message;

  const SubjectError(
    this.message, {
    String name = '',
    Color color = AppColors.red,
  }) : super(name: name, color: color);
}
