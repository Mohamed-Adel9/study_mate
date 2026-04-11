import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/features/exam/data/model/exam_model.dart';

import '../../../../exam/domain/use_cases/get_exam_use_case.dart';
import '../../../../subject/domain/use_cases/get_subject_use_case.dart';
import '../../../domain/entity/home_enitiy.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSubjectsUseCase getSubjects;
  final GetExamsUseCase getExams;

  HomeCubit(this.getSubjects, this.getExams)
      : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());

    final subjects = await getSubjects();
    final exams = await getExams();

    final urgent = _getUrgentExams(exams);

    final completed = exams.where((e) => e.isDone).length;

    emit(HomeLoaded(
      HomeData(
        subjects: subjects,
        exams: exams,
        urgentExams: urgent,
        completedTasks: completed,
        totalTasks: exams.length,
      ),
    ));
  }

  List<ExamModel> _getUrgentExams(List<ExamModel> exams) {
    final now = DateTime.now();
    return exams.where((exam) {
      final diff = exam.date.difference(now).inHours;
      return diff <= 48 && diff >= 0;
    }).toList();
  }
}