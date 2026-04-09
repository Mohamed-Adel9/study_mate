import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/features/exam/presentation/view/exam_screen.dart';
import 'package:study_mate/features/subject/presentation/view/subject_screen.dart';
import '../bloc/nav_bar_cubit.dart';
import '../bloc/nav_bar_state.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_main_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController pageController = PageController();

  static const List<Widget> _pages = [
    HomeMainScreen(),
    SubjectScreen(),
    ExamScreen(),
    SubjectScreen(),
    SubjectScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              context.read<NavBarCubit>().changeTab(index);
            },
            children: _pages,
          ),
          bottomNavigationBar: BottomNavBar(pageController: pageController),
        );
      },
    );
  }
}
