import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

@module
abstract class RegisterDatabaseModule {
  @lazySingleton
  @preResolve
  Future<Database> get database async {
    final appDirectory = await getApplicationDocumentsDirectory();
    await appDirectory.create(recursive: true);
    final databasePath = join(appDirectory.path, "cocktailz.db");

    return databaseFactoryIo.openDatabase(databasePath);
  }
}
