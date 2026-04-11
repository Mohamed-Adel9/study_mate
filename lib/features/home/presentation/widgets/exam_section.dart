import 'package:flutter/material.dart';
import 'package:study_mate/core/navigation/route_names.dart';
import 'package:study_mate/features/exam/data/model/exam_model.dart';

import '../../../exam/presentation/widgets/build_urgent_banner.dart';
import '../../../exam/presentation/widgets/exam_card.dart';

class ExamsSection extends StatelessWidget {
  const ExamsSection({super.key, required this.exams});

  final List<ExamModel> exams;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "الامتحانات القادمة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: () {
              Navigator.pushNamed(context, RouteNames.exam);
            }, child: const Text("عرض الكل")),
          ],
        ),
        const SizedBox(height: 10),
        exams.isEmpty
            ? Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text("No exams yet 🎉"),
              )
            : Column(
                children: [
                  buildUrgentBanner(exams),
                  SizedBox(height: 15,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      final isDone = exam.isDone ;
                      return examCard(exam,isDone);
                    },
                  ),
                  if(exams.length > 3)
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context, RouteNames.exam);
                    }, child: const Text("عرض كل الامتحانات")),
                ],
              ),
      ],
    );
  }
}
