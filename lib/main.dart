import 'package:flutter/material.dart';
import 'package:study_mate/app.dart';
import 'package:study_mate/core/app_initalizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();

  runApp(const StudyMateApp());
}



