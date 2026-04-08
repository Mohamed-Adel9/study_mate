import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/features/subject/presentation/widgets/subject_header.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../bloc/subject_cubit.dart';
import '../widgets/subject_grid.dart';
import 'add_subject_screen.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SubjectCubit>()..getSubjects(),
      child: const _SubjectView(),
    );
  }
}


class _SubjectView extends StatelessWidget {
  const _SubjectView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        onPressed: () => _openAddSubjectScreen(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              SizedBox(height: 20),
              SubjectHeader(),
              SizedBox(height: 10),
              Expanded(child: SubjectsGrid()),
            ],
          ),
        ),
      ),
    );
  }

  void _openAddSubjectScreen(BuildContext context) {
    final cubit = context.read<SubjectCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: AddSubjectScreen(),
        ),
      ),
    );
  }
}
