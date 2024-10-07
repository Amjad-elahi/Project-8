import 'package:get_it/get_it.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:get_storage/get_storage.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await GetStorage.init();
  getIt.registerSingleton<DataLayer>(DataLayer());
}
