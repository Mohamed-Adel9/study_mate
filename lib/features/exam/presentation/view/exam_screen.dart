import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/features/exam/presentation/bloc/exam_cubit.dart';
import 'package:study_mate/features/exam/presentation/bloc/exam_state.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../subject/presentation/bloc/subject_cubit.dart';
import '../widgets/build_urgent_banner.dart';
import '../widgets/exam_card.dart';
import 'add_exam_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          sl<ExamCubit>()
            ..getExams(),
        ),
        BlocProvider(
          create: (context) => sl<SubjectCubit>()..getSubjects(),
        ),
      ],
      child: Builder(
        builder: (context) =>Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<ExamCubit>()),
                      BlocProvider.value(value: context.read<SubjectCubit>()),
                    ],
                    child: const AddExamScreen(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<ExamCubit, ExamState>(
                builder: (context, state) {
                  if (state is ExamLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ExamLoaded) {
                    final exams = state.exams;

                    if (exams.isEmpty) {
                      return const Center(child: Text("لا يوجد امتحانات"));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// Title
                        const Text(
                          "الامتحانات",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight
                              .bold),
                        ),

                        const SizedBox(height: 4),

                        const Text("العد التنازلي للامتحانات"),

                        const SizedBox(height: 20),

                        /// Urgent Banner
                        buildUrgentBanner(exams),

                        const SizedBox(height: 20),

                        /// List
                        Expanded(
                          child: ListView.separated(
                            itemCount: exams.length,
                            separatorBuilder: (_, _) =>
                            const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final exam = exams[index];
                              final isDone = exam.isDone;
                              return GestureDetector(
                                  onLongPress: () {
                                    context.read<ExamCubit>().deleteExam(state.exams[index].id);
                                  },
                                  child: examCard(exam,isDone));
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ) ,

      ),
    );
  }
}