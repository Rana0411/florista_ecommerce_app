import 'dart:io';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@singleton
class HiveService {
  static Future<void> init(Directory dir) async {
    Hive.init(dir.path);
  }
}
