import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/order.dart';

abstract class InvoiceRepo {
  void addInvoice(Map<String, dynamic> invoiceData);

  Order createOrder(Drink drink, int quantity);
}
