import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/navigation/route_names.dart';
import 'package:study_mate/features/tasks/data/model/task_model.dart';

import '../../../tasks/presentation/widgets/task_card.dart';
import '../bloc/home/home_cubit.dart';

class TasksSection extends StatelessWidget {
  const TasksSection({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "مهام اليوم",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.pushNamed(context, RouteNames.addTask);
                // ✅ Reload home data after returning from AddTaskScreen
                //    so the new task appears without a manual refresh.
                if (context.mounted) {
                  context.read<HomeCubit>().loadHome();
                }
              },
              child: const Text("اضافة مهمة"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (tasks.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.check_circle_outline, size: 40, color: Colors.grey),
                SizedBox(height: 8),
                Text(
                  "لا توجد مهام لليوم",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => TaskCard(
              task: tasks[i],
              onToggle: () => context.read<HomeCubit>().toggleTask(tasks[i]),
            ),
          ),
      ],
    );
  }
}