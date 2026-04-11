import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/features/home/presentation/bloc/home/home_cubit.dart';
import 'package:study_mate/features/home/presentation/bloc/home/home_state.dart';
import 'package:study_mate/features/tasks/presentation/bloc/task_cubit.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../widgets/exam_section.dart';
import '../widgets/home_header.dart';
import '../widgets/progress_card.dart';
import '../widgets/tasks_section.dart';

class HomeMainScreen extends StatelessWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => sl<HomeCubit>()..loadHome(),
),
    BlocProvider(
      create: (context) => sl<TaskCubit>()..getTasks(),
    ),
  ],
  child: Builder(
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    // Top
                    HomeHeader(),
                    Column(
                      children: [
                        const SizedBox(height: 125),
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  if (state is HomeLoading) {
                                    return Center(child: const CircularProgressIndicator());
                                  }
                                  if (state is HomeLoaded) {
                                    final data = state.data;
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        ProgressCard(
                                            completedTasks: data.completedTasks,
                                            tasks: data.totalTasks),
                                        SizedBox(height: 20),
                                        TasksSection(tasks: data.todayTasks,),
                                        SizedBox(height: 20),
                                        ExamsSection(exams: data.exams,),


                                      ],
                                    );
                                  }
                                  return SizedBox(
                                    child: Center(child: Text("OPPS! There was An error")),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
);
  }
}
