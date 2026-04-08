import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/features/subject/presentation/widgets/subject_card.dart';

import '../bloc/subject_cubit.dart';
import '../bloc/subject_state.dart';

class SubjectsGrid extends StatelessWidget {
  const SubjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectCubit, SubjectState>(
      builder: (context, state) {
        if (state is SubjectLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SubjectError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is SubjectLoaded) {
          if (state.subjects.isEmpty) {
            return const Center(child: Text("لا توجد مواد بعد"));
          }

          return GridView.builder(
            itemCount: state.subjects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final subject = state.subjects[index];

              // Parse the color stored as an integer string (e.g. "4280391411").
              // Falls back to the index-based palette if the value is malformed.
              final color = _parseColor(subject.color, index);

              return SubjectCard(
                name: subject.name,
                color: color,
                icon: _getIcon(index),
                onDelete: () =>
                    context.read<SubjectCubit>().deleteSubject(subject.id),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// Parses a color stored as its integer ARGB value.
  Color _parseColor(String colorStr, int fallbackIndex) {
    final parsed = int.tryParse(colorStr);
    if (parsed != null) return Color(parsed);
    // Fallback palette for legacy entries stored in the old format.
    return _fallbackPalette[fallbackIndex % _fallbackPalette.length];
  }

  static const _fallbackPalette = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.amber,
  ];

  IconData _getIcon(int index) {
    const icons = [
      Icons.square_foot,
      Icons.science,
      Icons.biotech,
      Icons.menu_book,
      Icons.edit,
      Icons.account_balance,
    ];
    return icons[index % icons.length];
  }
}
