import 'package:flutter/material.dart';
import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/core/theme/app_styles.dart';

class SubjectHeader extends StatelessWidget {
  const SubjectHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children:  [
        Text(
          "المواد الدراسية",
          style: AppTextStyles.style30bold
        ),
        Text(
          "إدارة جميع موادك",
          style: AppTextStyles.style18.copyWith(color: AppColors.grey)
        ),
      ],
    );
  }
}