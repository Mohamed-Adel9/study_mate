import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 150,
      width: MediaQuery.sizeOf(context).width,
      color: AppColors.blue.withValues(alpha: .9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "مرحبا , محمد 👋 ",
            style: AppTextStyles.style30bold.copyWith(
              color: AppColors.white,
            ),
          ),
          Text(
            "مستعد للدراسه اليوم ",
            style: AppTextStyles.style25bold.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
