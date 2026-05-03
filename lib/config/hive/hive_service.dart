import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

@singleton
class HiveService {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
}