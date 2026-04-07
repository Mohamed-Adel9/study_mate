
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/view/home_screen.dart';

class StudyMateApp extends StatelessWidget {
  const StudyMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Mate',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: HomeScreen(),
    );
  }
}