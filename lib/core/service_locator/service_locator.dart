import 'package:get_it/get_it.dart';
import 'package:study_mate/features/subject/data/data_source/subject_local_data_source.dart';
import 'package:study_mate/features/subject/data/repository/subject_repository_impl.dart';
import 'package:study_mate/features/subject/domain/repository/subject_repository.dart';
import 'package:study_mate/features/subject/domain/use_cases/add_subject_use_case.dart';
import 'package:study_mate/features/subject/domain/use_cases/delet_subject_use_case.dart';
import 'package:study_mate/features/subject/domain/use_cases/delete_all_subjects_use_case.dart';
import 'package:study_mate/features/subject/domain/use_cases/get_subject_use_case.dart';
import 'package:study_mate/features/subject/presentation/bloc/subject_cubit.dart';

final sl = GetIt.instance;

Future<void> setupGetIt() async {
  /// 🔥 External services first
  // sl.registerLazySingleton(() => FirebaseAuth.instance);

  /// 📡 Data sources
  sl.registerLazySingleton<SubjectLocalDataSource>(
    () => SubjectLocalDataSourceImpl(),
  );

  ///📦 Repository
  sl.registerLazySingleton<SubjectRepository>(
    () => SubjectRepositoryImpl(localDataSource: sl()),
  );

  /// 🎯 Use cases
  sl.registerLazySingleton(() => AddSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAllSubjectsUseCase(sl()));

  /// 🧠 Cubit
  sl.registerFactory(
    () => SubjectCubit(
      addSubjectsUseCase: sl(),
      getSubjectsUseCase: sl(),
      deleteSubjectUseCase: sl(),
      deleteAllSubjectsUseCase: sl(),
    ),
  );
}
