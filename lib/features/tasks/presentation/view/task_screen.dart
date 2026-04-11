import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/widgets/add_thing_header.dart';
import 'package:study_mate/features/tasks/presentation/view/add_task_screen.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../subject/presentation/bloc/subject_cubit.dart';
import '../bloc/task_cubit.dart';
import '../bloc/task_state.dart';
import '../widgets/date_switcher.dart';
import '../widgets/empty_task_state.dart';
import '../widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

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
          sl<TaskCubit>()
            ..getTasks(),
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
                      BlocProvider.value(value: context.read<TaskCubit>()),
                      BlocProvider.value(value: context.read<SubjectCubit>()),
                    ],
                    child: const AddTaskScreen(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TaskLoaded) {
                    final tasks = state.tasks;
                    final done = tasks.where((e) => e.isDone).length;
                    final cubit = context.read<TaskCubit>();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title + progress
                        AddThingHeader(label: "جدول الدراسة",),
                        const SizedBox(height: 6),
                        Text("تم إنجاز $done من ${tasks.length} مهام "),

                        /// Date Switch
                        DateSwitcher(cubit: cubit),

                        const SizedBox(height: 20),

                        /// Tasks List / Empty
                        Expanded(
                          child: tasks.isEmpty
                              ? const EmptyTasksWidget()
                              : ListView.separated(
                            itemCount: tasks.length,
                            separatorBuilder: (_, _) =>
                            const SizedBox(height: 12),
                            itemBuilder: (_, i) =>
                                TaskCard(task: tasks[i]),
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