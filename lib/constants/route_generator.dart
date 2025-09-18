import 'package:ass1/features/day_report/view/day_report_view.dart';
import 'package:ass1/features/day_report/logic/day_report_cubit.dart';
import 'package:ass1/features/pending_invoice/view/pending_invoice_view.dart';
import 'package:ass1/features/pending_invoice/logic/pending_invoice_cubit.dart';
import 'package:ass1/features/popular_drinks/view/popular_drinks_view.dart';
import 'package:ass1/features/popular_drinks/logic/popular_drinks_cubit.dart';
import 'package:ass1/features/served_invoices/view/served_invoices_view.dart';
import 'package:ass1/features/served_invoices/logic/served_invoices_cubit.dart';
import 'package:ass1/features/add_invoice/logic/add_invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ass1/constants/routes.dart';
import 'package:ass1/features/home/view/home_view.dart';
import 'package:ass1/features/add_invoice/view/add_orders_view.dart';
import 'package:ass1/features/home/logic/home_controller.dart';
import 'package:ass1/di/service_locator.dart';
import 'package:ass1/repo/app_repo.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final appRepo = getIt<AppRepo>();

    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => HomeView(controller: getIt<HomeController>()),
        );

      case AppRoutes.addOrders:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddInvoiceCubit(appRepo),
            child: const AddInvoiceView(),
          ),
        );

      case AppRoutes.pendingOrders:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PendingInvoiceCubit(appRepo),
            child: const PendingOrdersView(),
          ),
        );

      case AppRoutes.servedInvoices:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ServedInvoicesCubit(appRepo),
            child: const ServedInvoices(),
          ),
        );

      case AppRoutes.popularItems:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PopularDrinksCubit(appRepo),
            child: const PopularDrinksView(),
          ),
        );

      case AppRoutes.dailyReport:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DayReportCubit(appRepo),
            child: const DayReportView(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Route "${settings.name}" not found',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                    ),
                    child: const Text('Go Home'),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}

// Placeholder views for empty files
