import 'package:get_it/get_it.dart';
import 'package:ass1/backend/backend_services.dart';
import 'package:ass1/backend/cache_storage.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:ass1/features/home/logic/home_controller.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register storage as singleton
  getIt.registerLazySingleton<CacheStorage>(() => CacheStorage());

  // Register backend services as singleton
  getIt.registerLazySingleton<BackendServices>(
    () => BackendServices(storage: getIt<CacheStorage>()),
  );

  // Register invoice repo as singleton to maintain state
  getIt.registerLazySingleton<AppRepo>(() => AppRepo(getIt<BackendServices>()));

  // Register home controller as singleton
  getIt.registerLazySingleton<HomeController>(
    () => HomeController(backendServices: getIt<BackendServices>()),
  );
}
