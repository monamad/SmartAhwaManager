import 'dart:collection';

import 'package:ass1/backend/backend_services.dart';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/data/models/order.dart';

class AppRepo {
  final BackendServices backendServices;

  AppRepo(this.backendServices);

  void addInvoice(Map<String, dynamic> invoiceData) {
    Invoice invoice = Invoice(
      createdAt: DateTime.now(),
      customerName: invoiceData['customerName'] ?? '',
      orders: invoiceData['orders'] ?? [],
      totalAmount: (invoiceData['orders'] as List<Order>).fold(
        0,
        (sum, order) => sum + order.price,
      ),
    );
    backendServices.createInvoice(invoice);
  }

  Order createOrder(Drink drink, int quantity) {
    Order order = Order(
      drink: drink,
      quantity: quantity,
      price: drink.price * quantity,
    );

    return order;
  }

  List<Invoice> get pendingInvoices => backendServices.pendingInvoices;
  List<Invoice> get servedInvoices => backendServices.servedInvoices;

  LinkedHashMap<Drink, int> getPopularDrinks() {
    return backendServices.mostPopularDrink();
  }
}
