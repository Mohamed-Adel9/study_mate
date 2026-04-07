import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/theme/app_colors.dart';

import '../bloc/nav_bar_cubit.dart';
import '../bloc/nav_bar_state.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.pageController,
  });

  static const List<String> _imageList = [
    "assets/images/nav_bar/home.png",
    "assets/images/nav_bar/open-book.png",
    "assets/images/nav_bar/calendar.png",
    "assets/images/nav_bar/to-do-list.png",
    "assets/images/nav_bar/calculator.png",
  ];

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Subject";
      case 2:
        return "Exams";
      case 3:
        return "Lists";
      case 4:
        return "GPA";
      default:
        return "";
    }
  }
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withValues(alpha: 0.08),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: state.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.blue,
            unselectedItemColor: AppColors.grey,
            showUnselectedLabels: true,
            elevation: 0,
            iconSize: 15,
            selectedIconTheme: IconThemeData(color: AppColors.blue,size: 15),

            onTap: (index) {
              context.read<NavBarCubit>().changeTab(index);

              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },

            items: List.generate(_imageList.length, (index) {
              final isSelected = state.currentIndex == index;

              return BottomNavigationBarItem(
                icon: Image.asset(
                  _imageList[index],
                  width: isSelected ? 26 : 20,
                  height: isSelected ? 26 : 20,
                  color: isSelected ? AppColors.blue : AppColors.grey,
                ),
                label: _getLabel(index),
              );
            }),
          ),
        );
      },
    );
  }
}