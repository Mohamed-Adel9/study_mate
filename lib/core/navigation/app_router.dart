import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/navigation/route_names.dart';
import 'package:study_mate/features/exam/presentation/view/exam_screen.dart';
import 'package:study_mate/features/home/presentation/bloc/nav_bar_cubit.dart';
import 'package:study_mate/features/subject/presentation/view/add_subject_screen.dart';
import 'package:study_mate/features/tasks/presentation/bloc/task_cubit.dart';
import 'package:study_mate/features/tasks/presentation/view/add_task_screen.dart';
import 'package:study_mate/features/tasks/presentation/view/task_screen.dart';

import '../../features/exam/presentation/bloc/exam_cubit.dart';
import '../../features/exam/presentation/view/add_exam_screen.dart';
import '../../features/home/presentation/view/home_screen.dart';
import '../../features/subject/presentation/bloc/subject_cubit.dart';
import '../../features/subject/presentation/view/subject_screen.dart';
import '../service_locator/service_locator.dart';
import '../theme/app_styles.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// subject router
      case RouteNames.subject:
        return MaterialPageRoute(builder: (context) => SubjectScreen());
      case RouteNames.addSubject:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SubjectCubit>(),
            child: AddSubjectScreen(),
          ),
        );

      /// exam router
      case RouteNames.exam:
        return MaterialPageRoute(builder: (context) => ExamScreen());
      case RouteNames.addExam:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<ExamCubit>()..getExams()),
              BlocProvider(
                create: (context) => sl<SubjectCubit>()..getSubjects(),
              ),
            ],
            child: AddExamScreen(),
          ),
        );


    /// task router
      case RouteNames.task:
        return MaterialPageRoute(builder: (context) => TaskScreen());
      case RouteNames.addTask:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
  providers: [
    BlocProvider(
            create: (context) => sl<TaskCubit>()..getTasks(),
),
    BlocProvider(
      create: (context) => sl<SubjectCubit>()..getSubjects(),
    ),

  ],
  child: AddTaskScreen(),
),
        );

      ///home router
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => NavBarCubit(),
            child: HomeScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Page not found", style: AppTextStyles.style25),
            ),
          ),
        );
    }
  }
}
