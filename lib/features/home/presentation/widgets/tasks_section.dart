import 'package:flutter/material.dart';
import 'package:study_mate/features/home/presentation/widgets/task_card.dart';

class TasksSection extends StatelessWidget {
  const TasksSection({super.key});

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
              onPressed: () {
                // todo ADD TASK
              },
              child: const Text("+ إضافة"),
            )
          ],
        ),
        const SizedBox(height: 10),
        const TaskCard(
          title: "مراجعة الرياضيات - الفصل 3",
          subject: "رياضيات",
          time: "09:00 AM",
          isDone: false,
        ),
        const TaskCard(
          title: "حل تمارين الفيزياء",
          subject: "فيزياء",
          time: "02:00 PM",
          isDone: true,
        ),
        const TaskCard(
          title: "قراءة الأدب الإنجليزي",
          subject: "إنجليزي",
          time: "05:00 PM",
          isDone: false,
        ),
      ],
    );
  }
}