import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/features/exam/data/model/exam_model.dart';
import 'package:study_mate/features/tasks/data/model/task_model.dart';

import '../../../../exam/domain/use_cases/get_exam_use_case.dart';
import '../../../../subject/domain/use_cases/get_subject_use_case.dart';
import '../../../../tasks/domain/use_cases/add_task_use_case.dart';
import '../../../../tasks/domain/use_cases/get_task_use_case.dart';
import '../../../domain/entity/home_enitiy.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSubjectsUseCase getSubjects;
  final GetExamsUseCase getExams;
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTasksUseCase;

  HomeCubit(this.getSubjects, this.getExams, this.getTasks, this.addTasksUseCase)
      : super(HomeInitial());

  List<TaskModel> _allTasks = [];

  Future<void> loadHome() async {
    emit(HomeLoading());

    final subjects = await getSubjects();
    final exams = await getExams();
    final tasks = await getTasks();

    _allTasks = tasks;

    final todayTasks = _getTodayTasks(_allTasks);

    emit(HomeLoaded(
      HomeData(
        subjects: subjects,
        exams: exams,
        urgentExams: _getUrgentExams(exams),
        todayTasks: todayTasks,
        completedTasks: todayTasks.where((t) => t.isDone).length,
        totalTasks: todayTasks.length,
      ),
    ));
  }

  Future<void> toggleTask(TaskModel task) async {
    final updated = task.copyWith(isDone: !task.isDone);
    _allTasks = _allTasks.map((t) => t.id == task.id ? updated : t).toList();
    await addTasksUseCase(_allTasks);

    final currentState = state;
    if (currentState is HomeLoaded) {
      final todayTasks = _getTodayTasks(_allTasks);
      emit(HomeLoaded(
        HomeData(
          subjects: currentState.data.subjects,
          exams: currentState.data.exams,
          urgentExams: currentState.data.urgentExams,
          todayTasks: todayTasks,
          completedTasks: todayTasks.where((t) => t.isDone).length,
          totalTasks: todayTasks.length,
        ),
      ));
    }
  }

  List<ExamModel> _getUrgentExams(List<ExamModel> exams) {
    final now = DateTime.now();
    return exams.where((exam) {
      final diff = exam.date.difference(now).inHours;
      return diff <= 48 && diff >= 0;
    }).toList();
  }

  List<TaskModel> _getTodayTasks(List<TaskModel> tasks) {
    final now = DateTime.now();
    return tasks.where((task) {
      return task.date.year == now.year &&
          task.date.month == now.month &&
          task.date.day == now.day;
    }).toList();
  }
}