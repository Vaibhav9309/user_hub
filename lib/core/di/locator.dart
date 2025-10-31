import 'package:get_it/get_it.dart';
import '../../data/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initLocator() async {
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => UserRepository(sl()));
}
