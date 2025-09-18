import 'package:ass1/constants/route_generator.dart';
import 'package:ass1/constants/routes.dart';
import 'package:ass1/di/service_locator.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:ass1/logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(getIt<AppRepo>()),
      child: MaterialApp(
        title: 'Coffee Shop Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.home,

        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
