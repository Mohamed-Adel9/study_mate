import 'package:get_it/get_it.dart';
import 'package:study_mate/features/exam/domain/use_cases/add_exam_use_case.dart';
import 'package:study_mate/features/subject/data/data_source/subject_local_data_source.dart';
import 'package:study_mate/features/subject/data/repository/subject_repository_impl.dart';
import 'package:study_mate/features/subject/domain/repository/subject_repository.dart';
import 'package:study_mate/features/subject/domain/use_cases/add_subject_use_case.dart';
import 'package:study_mate/features/subject/domain/use_cases/delet_subject_use_case.dart';
import 'package:study_mate/features/subject/domain/use_cases/delete_all_subjects_use_case.dart';
import 'package:study_mate/features/subject/domain/use_cases/get_subject_use_case.dart';
import 'package:study_mate/features/subject/presentation/bloc/subject_cubit.dart';

import '../../features/exam/data/data_source/exam_local_data_source.dart';
import '../../features/exam/data/repository/exam_repository_impl.dart';
import '../../features/exam/domain/repository/exam_repository.dart';
import '../../features/exam/domain/use_cases/delet_exam_use_case.dart';
import '../../features/exam/domain/use_cases/delete_all_exams_use_case.dart';
import '../../features/exam/domain/use_cases/get_exam_use_case.dart';
import '../../features/exam/presentation/bloc/exam_cubit.dart';

final sl = GetIt.instance;

Future<void> setupGetIt() async {
  /// 🔥 External services first
  // sl.registerLazySingleton(() => FirebaseAuth.instance);

  /// 📡 Data sources
  sl.registerLazySingleton<SubjectLocalDataSource>(
    () => SubjectLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ExamLocalDataSource>(
        () => ExamLocalDataSourceImpl(),
  );
  ///📦 Repository
  sl.registerLazySingleton<SubjectRepository>(
    () => SubjectRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ExamRepository>(
        () => ExamRepositoryImpl(localDataSource: sl()),
  );

  /// 🎯 Use cases
  sl.registerLazySingleton(() => AddSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAllSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => AddExamUseCase(sl()));
  sl.registerLazySingleton(() => GetExamsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteExamsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAllExamsUseCase(sl()));

  /// 🧠 Cubit
  sl.registerFactory(
    () => SubjectCubit(
      addSubjectsUseCase: sl(),
      getSubjectsUseCase: sl(),
      deleteSubjectUseCase: sl(),
      deleteAllSubjectsUseCase: sl(),
    ),
  );
  sl.registerFactory(
        () => ExamCubit(
      addExamsUseCase: sl(),
      getExamsUseCase: sl(),
      deleteExamUseCase: sl(),
      deleteAllExamsUseCase: sl(),
          subjectCubit: sl(),
    ),
  );
}
