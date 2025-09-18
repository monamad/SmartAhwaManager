import 'package:get_it/get_it.dart';
import 'package:ass1/di/modules/backend_module.dart';
import 'package:ass1/di/modules/Ui_module.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  BackendModule.registerDependencies(getIt);
  UiModule.registerDependencies(getIt);
}
