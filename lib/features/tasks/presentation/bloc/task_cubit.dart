import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/features/subject/presentation/bloc/subject_cubit.dart';
import 'package:study_mate/features/tasks/domain/use_cases/delete_task_use_case.dart';

import '../../data/model/task_model.dart';
import '../../domain/use_cases/add_task_use_case.dart';
import '../../domain/use_cases/delete_all_tasks_use_case.dart';
import '../../domain/use_cases/get_task_use_case.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTasksUseCase;
  final DeleteTasksUseCase deleteTaskUseCase;
  final DeleteAllTasksUseCase deleteAllTasksUseCase;

  final SubjectCubit subjectCubit;

  TaskCubit({
    required this.getTasksUseCase,
    required this.addTasksUseCase,
    required this.deleteTaskUseCase,
    required this.deleteAllTasksUseCase,
    required this.subjectCubit,
  }) : super(TaskInit());

  DateTime selectedDate = DateTime.now();

  List<TaskModel> allTasks = [];

  /// ── GET TASKS ──────────────────────────
  Future<void> getTasks() async {
    emit(TaskLoading());

    try {
      final tasks = await getTasksUseCase();

      final now = DateTime.now();
      bool anyUpdated = false;

      final updatedTasks = tasks.map((task) {
        if (!task.isDone && task.date.isBefore(now)) {
          anyUpdated = true;
          return task.copyWith(isDone: true);
        }
        return task;
      }).toList();

      if (anyUpdated) {
        await addTasksUseCase(updatedTasks);
      }

      /// 🔥 SAVE ALL TASKS
      allTasks = updatedTasks;

      /// 🔥 FILTER BY SELECTED DATE
      final filtered = _filterTasksByDate();

      emit(TaskLoaded(filtered,selectedDate: selectedDate));

    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  List<TaskModel> _filterTasksByDate() {
    return allTasks.where((task) {
      return task.date.year == selectedDate.year &&
          task.date.month == selectedDate.month &&
          task.date.day == selectedDate.day;
    }).toList();
  }

  void nextDay() {
    selectedDate = selectedDate.add(const Duration(days: 1));
    emit(TaskLoaded(_filterTasksByDate(),selectedDate: selectedDate));
  }

  void previousDay() {
    selectedDate = selectedDate.subtract(const Duration(days: 1));
    emit(TaskLoaded(_filterTasksByDate(),selectedDate: selectedDate));
  }

  Future<void> toggleTask(TaskModel task) async {
    final updated = task.copyWith(isDone: !task.isDone);

    final updatedList = allTasks.map((t) {
      return t.id == task.id ? updated : t;
    }).toList();

    allTasks = updatedList;

    await addTasksUseCase(updatedList);

    emit(TaskLoaded(_filterTasksByDate(),selectedDate: selectedDate));
  }
  /// ── ADD TASK ───────────────────────────
  Future<void> addTask() async {
    final subjectId = state.selectedSubjectId;
    final subjectName = state.selectedSubjectName ?? subjectId ?? '';
    final date = state.selectedDate;
    final isDone = state.isDone;
    final title = state.title;
    final time = state.selectedTime;

    if (subjectId == null || date == null || time == null) return;

    final taskDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subjectId: subjectId,
      subjectName: subjectName,
      date: taskDateTime,
      isDone: isDone, title: title!,
    );

    try {
      // ✅ Always build on allTasks — never the filtered list —
      //    so tasks on other dates are never lost.
      final updatedAllTasks = List<TaskModel>.from(allTasks)..add(newTask);
      updatedAllTasks.sort((a, b) => a.date.compareTo(b.date));

      await addTasksUseCase(updatedAllTasks);

      // ✅ Keep allTasks in sync.
      allTasks = updatedAllTasks;

      // ✅ Snap the date switcher to the new task's date so the user
      //    sees it immediately without having to navigate manually.
      selectedDate = taskDateTime;

      emit(TaskLoaded(
        _filterTasksByDate(),
        selectedDate: selectedDate,
      ));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// ── DELETE TASK ────────────────────────
  Future<void> deleteTask(String id) async {
    try {
      await deleteTaskUseCase(id);
      await getTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// ── DELETE ALL ─────────────────────────
  Future<void> deleteAllTasks() async {
    try {
      await deleteAllTasksUseCase();
      emit(TaskLoaded([]));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  /// ── Update Subject ─────────────────────
  void selectTheSubject(String? id,String subjectName) {
    emit(state.copyWith(selectedSubjectId: id,selectedSubjectName: subjectName));
  }

  void updateTitle(String value) {
    emit(state.copyWith(title: value));
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
        state.selectedTime != null &&
        state.title != null &&
        state.title!.isNotEmpty;
  }
}