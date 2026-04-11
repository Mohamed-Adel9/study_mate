import 'package:flutter/material.dart';
import 'package:study_mate/core/navigation/app_router.dart';
import 'package:study_mate/core/navigation/route_names.dart';
import 'core/theme/app_theme.dart';

class StudyMateApp extends StatelessWidget {
  const StudyMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Mate',
      debugShowCheckedModeBanner: false,
      ///theme
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,

      ///navigation
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}