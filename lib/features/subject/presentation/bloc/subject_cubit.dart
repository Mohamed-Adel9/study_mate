
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/features/subject/domain/use_cases/delet_subject_use_case.dart';
import 'package:study_mate/features/subject/presentation/bloc/subject_state.dart';

import '../../data/model/subject_model.dart';
import '../../domain/use_cases/add_subject_use_case.dart';
import '../../domain/use_cases/delete_all_subjects_use_case.dart';
import '../../domain/use_cases/get_subject_use_case.dart';

class SubjectCubit extends Cubit<SubjectState> {
  final GetSubjectsUseCase getSubjectsUseCase;
  final AddSubjectsUseCase addSubjectsUseCase;
  final DeleteSubjectsUseCase deleteSubjectUseCase;
  final DeleteAllSubjectsUseCase deleteAllSubjectsUseCase;

  SubjectCubit({
    required this.getSubjectsUseCase,
    required this.addSubjectsUseCase,
    required this.deleteSubjectUseCase,
    required this.deleteAllSubjectsUseCase,
  }) : super(const SubjectInit());

  // Getters for the add-subject form

  String get _currentName =>
      state is SubjectLoaded ? (state as SubjectLoaded).name : '';

  Color get _currentColor =>
      state is SubjectLoaded ? (state as SubjectLoaded).color : AppColors.blue;


  //Subjects CRUD

  /// Load all subjects from storage.
  Future<void> getSubjects() async {
    emit(SubjectLoading());
    try {
      final subjects = await getSubjectsUseCase();
      emit(SubjectLoaded(subjects));
    } catch (e) {
      emit(SubjectError(e.toString()));
    }
  }

  /// Add a new subject using the current form values, then reset the form.
  Future<void> addSubject() async {
    final name = _currentName.trim();
    if (name.isEmpty) return;


    final newSubject = SubjectModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      color: _currentColor.toARGB32().toString(), // e.g. "4280391411"
    );

    try {
      final latest = await getSubjectsUseCase();
      final updatedList = List<SubjectModel>.from(latest)..add(newSubject);
      await addSubjectsUseCase(updatedList);

      emit(SubjectLoaded(updatedList));
    } catch (e) {
      emit(SubjectError(e.toString()));
    }
  }

  /// Delete a subject by [id] and refresh the list.
  Future<void> deleteSubject(String id) async {
    try {
      await deleteSubjectUseCase(id);
      await getSubjects();
    } catch (e) {
      emit(SubjectError(e.toString()));
    }
  }

  /// Delete every subject.
  Future<void> deleteAllSubjects() async {
    try {
      await deleteAllSubjectsUseCase();
      emit(const SubjectLoaded([]));
    } catch (e) {
      emit(SubjectError(e.toString()));
    }
  }

  //  Form helpers

  /// Called whenever the name text field changes.
  void updateName(String value) {
    _emitFormUpdate(name: value);
  }

  /// Called when the user taps a color swatch.
  void selectColor(Color color) {
    _emitFormUpdate(color: color);
  }

  /// Resets form state back to defaults (call after successful add if needed).
  void resetForm() {
    if (state is SubjectLoaded) {
      emit((state as SubjectLoaded).copyWith(
        name: '',
        color: AppColors.blue,
      ));
    }
  }

  // ── Private ───────────────────────────────────────────────────────────────

  void _emitFormUpdate({String? name, Color? color}) {
    if (state is SubjectLoaded) {
      emit((state as SubjectLoaded).copyWith(name: name, color: color));
    } else {
      // Edge case: cubit not yet loaded — bootstrap with an empty list.
      emit(SubjectLoaded(
        const [],
        name: name ?? _currentName,
        color: color ?? _currentColor,
      ));
    }
  }
}
