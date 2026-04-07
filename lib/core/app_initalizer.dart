import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_mate/core/service_locator/service_locator.dart';

class AppInitializer {
  static Future<void> init() async {
    // await _initFirebase();
    await _initLocalDb();
    await _initDI();
  }

  // static Future<void> _initFirebase() async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }



  static Future<void> _initLocalDb() async {
    await Hive.initFlutter();
  }

  static Future<void> _initDI() async {
    setupGetIt();
  }
}