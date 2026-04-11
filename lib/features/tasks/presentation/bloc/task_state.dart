import 'package:flutter/material.dart';

import '../../data/model/task_model.dart';

class TaskState {
  final String? selectedSubjectId;
  final String? selectedSubjectName;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final bool isLoading;
  final bool isDone;
  final String? error;
  final String? title;
  final bool clearSubject;
  final bool clearDate;
  final bool clearTime;

  TaskState({
    this.selectedSubjectName,
    this.selectedSubjectId,
    this.selectedDate,
    this.selectedTime,
    this.isLoading = false,
    this.error, this.clearSubject = false,  this.clearDate=false,  this.clearTime=false,
     this.isDone = false, this.title,
  });

  TaskState copyWith({
    String? selectedSubjectId,
    String? selectedSubjectName,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    bool? isLoading,
    bool? isDone,
    String? error,
    String? title,
    bool clearSubject = false,
    bool clearDate = false,
    bool clearTime = false,
  }) {
    return TaskState(
      selectedSubjectId:
          clearSubject ? null : (selectedSubjectId ?? this.selectedSubjectId),
      selectedSubjectName:
          clearSubject ? null : (selectedSubjectName ?? this.selectedSubjectName),
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
      isLoading: isLoading ?? this.isLoading,
      isDone: isDone ?? this.isDone,
      error: error,
      title: title ?? this.title,
    );
  }
}

class TaskInit extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  TaskLoaded(this.tasks, {
    super.selectedSubjectId,
    super.selectedSubjectName,
    super.selectedDate,
    super.selectedTime,
    super.title,
  });

  @override
  TaskState copyWith({
    String? selectedSubjectId,
    String? selectedSubjectName,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    bool? isLoading,
    bool? isDone,
    String? error,
    String? title,
    bool clearSubject = false,
    bool clearDate = false,
    bool clearTime = false,
  }) {
    return TaskLoaded(
      tasks,
      selectedSubjectId: clearSubject ? null : (selectedSubjectId ?? this.selectedSubjectId),
      selectedSubjectName: clearSubject ? null : (selectedSubjectName ?? this.selectedSubjectName),
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
      title: title ?? this.title,
    );
  }
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}
