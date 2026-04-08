import 'package:flutter/material.dart';
import 'package:study_mate/core/theme/app_colors.dart';

/// Header for the Add Subject screen.
/// Extracted as a proper [StatelessWidget] instead of a bare function
/// so it participates correctly in the widget tree.
class AddSubjectHeader extends StatelessWidget {
  const AddSubjectHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back,color: AppColors.grey,),
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(width: 8),
        const Text(
          "إضافة مادة جديدة",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
