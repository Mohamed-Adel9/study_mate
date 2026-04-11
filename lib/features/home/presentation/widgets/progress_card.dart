import 'package:flutter/material.dart';
import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/core/theme/app_styles.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key, required this.tasks, required this.completedTasks});

  final int tasks ;
  final int completedTasks ;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.blue, AppColors.green],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "تقدم اليوم",
            style: AppTextStyles.styleBold18.copyWith(
              color: AppColors.white
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(
                "المهام المكتملة",
                style: AppTextStyles.style14.copyWith(
                    color: AppColors.white.withValues(alpha: .75),
                ),
              ),
              Text(
                "$completedTasks/$tasks",
                style: AppTextStyles.styleBold18.copyWith(
                    color: AppColors.white
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: completedTasks/tasks,
              minHeight: 8,
              backgroundColor: Colors.white24,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}