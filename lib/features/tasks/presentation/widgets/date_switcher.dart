import 'package:flutter/material.dart';
import 'package:study_mate/core/theme/app_colors.dart';

import '../../../../core/utils/date_helper.dart';
import '../bloc/task_cubit.dart';

class DateSwitcher extends StatelessWidget {
  final TaskCubit cubit;

  const DateSwitcher({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final date = cubit.selectedDate;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: cubit.previousDay,
            icon: const Icon(Icons.arrow_back,color: AppColors.lightText,),
          ),

          Column(
            children: [
              Text(
                formatDate(date),
                style: const TextStyle(fontSize: 16),
              ),
              Text(isToday(date) ? "اليوم" : ""),
            ],
          ),

          IconButton(
            onPressed: cubit.nextDay,
            icon: const Icon(Icons.arrow_forward,color: AppColors.lightText),
          ),
        ],
      ),
    );
  }
}