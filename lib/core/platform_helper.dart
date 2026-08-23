import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformHelper {
  PlatformHelper._();

  static bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
}
