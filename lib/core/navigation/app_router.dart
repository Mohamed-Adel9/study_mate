import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/navigation/route_names.dart';
import 'package:study_mate/features/home/presentation/bloc/nav_bar_cubit.dart';

import '../../features/home/presentation/view/home_screen.dart';
import '../../features/subject/presentation/view/subject_screen.dart';
import '../theme/app_styles.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
    /// login router
      case RouteNames.subject:
        return MaterialPageRoute(builder: (context) => SubjectScreen());


    ///home router
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => NavBarCubit(),
                child: HomeScreen(),
              ),
        );


      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text("Page not found", style: AppTextStyles.style25),
                ),
              ),
        );
    }
  }
}