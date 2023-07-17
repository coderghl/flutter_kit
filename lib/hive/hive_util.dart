import 'package:hive_flutter/hive_flutter.dart';

import 'config.dart';

class HiveUtil {
  static late Box appBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    appBox = await Hive.openBox(kAppBoxKey);
  }
}
