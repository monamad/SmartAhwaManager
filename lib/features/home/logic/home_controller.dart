import 'package:ass1/backend/backend_services.dart';
import 'package:flutter/material.dart';
import 'package:ass1/constants/routes.dart';

class HomeController {
  final BackendServices _backendServices;

  HomeController({required BackendServices backendServices})
    : _backendServices = backendServices;

  void navigateToAddOrders(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addOrders);
  }

  void navigateToPendingOrders(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pendingOrders);
  }

  void showServedInvoices(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.servedInvoices);
  }

  void showDailyReport(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dailyReport);
  }

  void showPopularItems(BuildContext context) {
    final popularDrinks = _backendServices.mostPopularDrink();
    Navigator.pushNamed(
      context,
      AppRoutes.popularItems,
      arguments: popularDrinks,
    );
  }

  void showTotalInvoicesServed(BuildContext context) {
    final totalOrders = _backendServices.totalInvoicesServed();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Total Invoices Served'),
        content: Text('Total: $totalOrders invoices'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
