import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static String get googleClientIdWeb => dotenv.env['GOOGLE_CLIENT_ID_WEB']!;
  static String get googleClientIdIos => dotenv.env['GOOGLE_CLIENT_ID_IOS']!;
}
