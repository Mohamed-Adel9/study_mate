import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/features/exam/domain/use_cases/delet_exam_use_case.dart';
import 'package:study_mate/features/subject/presentation/bloc/subject_cubit.dart';

import '../../data/model/exam_model.dart';
import '../../domain/use_cases/add_exam_use_case.dart';
import '../../domain/use_cases/delete_all_exams_use_case.dart';
import '../../domain/use_cases/get_exam_use_case.dart';
import 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final GetExamsUseCase getExamsUseCase;
  final AddExamUseCase addExamsUseCase;
  final DeleteExamsUseCase deleteExamUseCase;
  final DeleteAllExamsUseCase deleteAllExamsUseCase;

  final SubjectCubit subjectCubit;

  ExamCubit({
    required this.getExamsUseCase,
    required this.addExamsUseCase,
    required this.deleteExamUseCase,
    required this.deleteAllExamsUseCase,
    required this.subjectCubit,
  }) : super(ExamInit());

  /// ── GET EXAMS ──────────────────────────
  Future<void> getExams() async {
    emit(ExamLoading());
    try {
      final exams = await getExamsUseCase();
      emit(ExamLoaded(exams));
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  /// ── ADD EXAM ───────────────────────────
  Future<void> addExam() async {
    final subjectId = state.selectedSubjectId;
    final subjectName = state.selectedSubjectName ?? subjectId ?? '';
    final date = state.selectedDate;
    final time = state.selectedTime;

    if (subjectId == null || date == null || time == null) return;

    final examDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final newExam = ExamModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subjectId: subjectId,
      subjectName: subjectName,
      date: examDateTime,
    );

    try {
      final currentState = state;

      if (currentState is ExamLoaded) {
        final updatedList = List<ExamModel>.from(currentState.exams)
          ..add(newExam);
        updatedList.sort((a, b) => a.date.compareTo(b.date));
        await addExamsUseCase(updatedList);

        emit(ExamLoaded(
          updatedList,
          selectedSubjectId: null,
          selectedSubjectName: null,
          selectedDate: null,
          selectedTime: null,
        ));
      } else {
        await addExamsUseCase([newExam]);
        await getExams();
      }
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  /// ── DELETE EXAM ────────────────────────
  Future<void> deleteExam(String id) async {
    try {
      await deleteExamUseCase(id);
      await getExams();
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  /// ── DELETE ALL ─────────────────────────
  Future<void> deleteAllExams() async {
    try {
      await deleteAllExamsUseCase();
      emit(ExamLoaded([]));
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  /// ── Update Subject ─────────────────────
  void selectTheSubject(String? id,String subjectName) {
    emit(state.copyWith(selectedSubjectId: id,selectedSubjectName: subjectName));
  }

  /// ── Update Date ────────────────────────
  void selectTheDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  /// ── Update Time ────────────────────────
  void selectTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  /// ── Validation ─────────────────────────
  bool validate() {
    return state.selectedSubjectId != null &&
        state.selectedDate != null &&
        state.selectedTime != null;
  }
}