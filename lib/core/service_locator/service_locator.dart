
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupGetIt() async {
  /// 🔥 External services first
  // sl.registerLazySingleton(() => FirebaseAuth.instance);
  //
  //
  // /// 📡 Data sources
  // sl.registerLazySingleton<PaymentRemoteDataSource>(
  //       () => PaymentRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  // );
  // sl.registerLazySingleton<PaymentLocalDataSource>(
  //       () => PaymentLocalDataSourceImpl(),
  // );
  //
  // ///📦 Repository
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  //
  //
  // /// 🎯 Use cases
  // sl.registerLazySingleton(() => LoginUseCase(sl()));
  //
  //
  // /// 🧠 Cubit
  // sl.registerFactory(() => CheckoutCubit(sl()));

}