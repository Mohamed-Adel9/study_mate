import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/navigation/route_names.dart';
import 'package:study_mate/features/home/presentation/bloc/nav_bar_cubit.dart';
import 'package:study_mate/features/subject/presentation/view/add_subject_screen.dart';

import '../../features/home/presentation/view/home_screen.dart';
import '../../features/subject/presentation/bloc/subject_cubit.dart';
import '../../features/subject/presentation/view/subject_screen.dart';
import '../service_locator/service_locator.dart';
import '../theme/app_styles.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
    /// subject router
      case RouteNames.subject:
        return MaterialPageRoute(builder: (context) => SubjectScreen());

      case RouteNames.addSubject:
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => sl<SubjectCubit>(),
              child: AddSubjectScreen(),
            ));


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