import 'dart:collection';
import 'package:ass1/backend/interfaces/storage_interface.dart';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/invoice.dart';
import 'package:flutter/foundation.dart';

class BackendServices {
  final Storage storage;

  BackendServices({required this.storage});

  void createInvoice(Invoice invoice) {
    invoice.id = storage.pendingInvoices.length + 1;
    storage.addPendingInvoice(invoice);
  }

  void completeInvoice(Invoice invoice) {
    invoice.invoiceStatus = InvoiceStatus.completed;
    int invoiceIndex = binarySearch(
      storage.pendingInvoices.map((e) => e.id).toList(),
      invoice.id,
    );
    if (invoiceIndex == -1) {
      throw Exception('Invoice not found in pending invoices');
    }

    storage.removePendingInvoice(invoiceIndex);

    storage.addCompletedInvoice(invoice);
  }

  void clearstorage() {
    storage.clearStorage();
  }

  double totalIncome() {
    double total = 0;
    for (var invoice in storage.pendingInvoices) {
      total += invoice.totalAmount;
    }
    for (var invoice in storage.completedInvoices) {
      total += invoice.totalAmount;
    }
    return total;
  }

  int totalInvoicesServed() {
    int total = 0;
    for (var invoice in storage.completedInvoices) {
      for (var order in invoice.orders) {
        total += order.quantity;
      }
    }
    return total;
  }

  List<Invoice> get pendingInvoices => storage.pendingInvoices;
  List<Invoice> get servedInvoices => storage.completedInvoices;

  LinkedHashMap<Drink, int> mostPopularDrink() {
    Map<Drink, int> drinkCount = {};

    for (var invoice in storage.completedInvoices) {
      print(invoice.orders.length);

      for (var order in invoice.orders) {
        print(order.drink.name);
        drinkCount.update(
          order.drink,
          (value) => value + order.quantity,
          ifAbsent: () => order.quantity,
        );
      }
    }
    print(drinkCount.values);
    var sortedEntries = drinkCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return LinkedHashMap<Drink, int>.fromEntries(sortedEntries);
  }
}
