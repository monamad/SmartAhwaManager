import 'package:ass1/constants/route_generator.dart';
import 'package:ass1/constants/routes.dart';
import 'package:ass1/di/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,

      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
