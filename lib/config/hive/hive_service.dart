import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

@singleton
class HiveService {
  @preResolve
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
}
