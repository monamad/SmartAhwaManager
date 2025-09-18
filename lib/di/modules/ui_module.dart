import 'package:ass1/features/add_invoice/repo/implementations/invoice_repository_impl.dart';
import 'package:ass1/features/add_invoice/repo/interfaces/invoice_repository.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:ass1/backend/backend_services.dart';
import 'package:ass1/features/home/logic/home_controller.dart';

class UiModule {
  static void registerDependencies(GetIt getIt) {
    getIt.registerLazySingleton<HomeController>(
      () => HomeController(backendServices: getIt<BackendServices>()),
    );
    getIt.registerLazySingleton<AppRepo>(
      () => AppRepoImpl(getIt<BackendServices>()),
    );
    getIt.registerLazySingleton<InvoiceRepo>(
      () => InvoiceRepositoryImpl(getIt<BackendServices>()),
    );
  }
}
