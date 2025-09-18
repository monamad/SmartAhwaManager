import 'dart:collection';
import 'package:ass1/backend/backend_services.dart';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/invoice.dart';

abstract class AppRepo {
  List<Invoice> get pendingInvoices;
  List<Invoice> get servedInvoices;

  LinkedHashMap<Drink, int> getPopularDrinks();
  double totalIncome();
  int totalInvoicesServed();
  void completeInvoice(Invoice invoice);
}

class AppRepoImpl extends AppRepo {
  final BackendServices backendServices;

  AppRepoImpl(this.backendServices);
  @override
  List<Invoice> get pendingInvoices => backendServices.pendingInvoices;
  @override
  List<Invoice> get servedInvoices => backendServices.servedInvoices;

  @override
  LinkedHashMap<Drink, int> getPopularDrinks() {
    return backendServices.mostPopularDrink();
  }

  @override
  double totalIncome() {
    return backendServices.totalIncome();
  }

  @override
  int totalInvoicesServed() {
    return backendServices.totalInvoicesServed();
  }

  @override
  void completeInvoice(Invoice invoice) {
    backendServices.completeInvoice(invoice);
  }
}
