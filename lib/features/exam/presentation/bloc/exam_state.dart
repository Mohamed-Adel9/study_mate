import 'package:flutter/material.dart';

import '../../data/model/exam_model.dart';

class ExamState {
  final String? selectedSubjectId;
  final String? selectedSubjectName;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final bool isLoading;
  final String? error;
  final bool clearSubject;
  final bool clearDate;
  final bool clearTime;

  ExamState({
    this.selectedSubjectName,
    this.selectedSubjectId,
    this.selectedDate,
    this.selectedTime,
    this.isLoading = false,
    this.error, this.clearSubject = false,  this.clearDate=false,  this.clearTime=false,
  });

  // FIX: added clearSubject/clearDate/clearTime flags so copyWith can reset fields to null
  ExamState copyWith({
    String? selectedSubjectId,
    String? selectedSubjectName,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    bool? isLoading,
    String? error,
    bool clearSubject = false,
    bool clearDate = false,
    bool clearTime = false,
  }) {
    return ExamState(
      selectedSubjectId:
          clearSubject ? null : (selectedSubjectId ?? this.selectedSubjectId),
      selectedSubjectName:
          clearSubject ? null : (selectedSubjectName ?? this.selectedSubjectName),
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ExamInit extends ExamState {}

class ExamLoading extends ExamState {}

class ExamLoaded extends ExamState {
  final List<ExamModel> exams;

  ExamLoaded(this.exams, {
    super.selectedSubjectId,
    super.selectedSubjectName,
    super.selectedDate,
    super.selectedTime,
  });

  @override
  ExamState copyWith({
    String? selectedSubjectId,
    String? selectedSubjectName,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    bool? isLoading,
    String? error,
    bool clearSubject = false,
    bool clearDate = false,
    bool clearTime = false,
  }) {
    return ExamLoaded(
      exams,
      selectedSubjectId: clearSubject ? null : (selectedSubjectId ?? this.selectedSubjectId),
      selectedSubjectName: clearSubject ? null : (selectedSubjectName ?? this.selectedSubjectName),
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
    );
  }
}

class ExamError extends ExamState {
  final String message;

  ExamError(this.message);
}
