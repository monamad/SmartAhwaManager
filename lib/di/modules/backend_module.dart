import 'package:get_it/get_it.dart';
import 'package:ass1/backend/backend_services.dart';
import 'package:ass1/backend/cache_storage.dart';

class BackendModule {
  static void registerDependencies(GetIt getIt) {
    getIt.registerLazySingleton<CacheStorage>(() => CacheStorage());

    getIt.registerLazySingleton<BackendServices>(
      () => BackendServices(storage: getIt<CacheStorage>()),
    );

   
  }
}
