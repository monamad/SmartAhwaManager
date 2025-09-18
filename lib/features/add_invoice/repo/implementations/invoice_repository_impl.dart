import 'package:ass1/backend/backend_services.dart';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/data/models/order.dart';
import 'package:ass1/features/add_invoice/repo/interfaces/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepo {
  final BackendServices _backendServices;

  InvoiceRepositoryImpl(this._backendServices);

  @override
  void addInvoice(Map<String, dynamic> invoiceData) {
    if (invoiceData['customerName'] == null ||
        (invoiceData['customerName'] as String).isEmpty) {
      throw ArgumentError('Customer name is required');
    }

    if (invoiceData['orders'] == null ||
        (invoiceData['orders'] as List).isEmpty) {
      throw ArgumentError('Orders are required');
    }

    final Invoice invoice = Invoice(
      createdAt: DateTime.now(),
      customerName: invoiceData['customerName'] ?? '',
      orders: List<Order>.from(invoiceData['orders'] ?? []),
      totalAmount: _calculateTotalAmount(invoiceData['orders']),
    );

    _backendServices.createInvoice(invoice);
  }

  @override
  Order createOrder(Drink drink, int quantity) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be greater than 0');
    }
    return Order(
      drink: drink,
      quantity: quantity,
      price: drink.price * quantity,
    );
  }

  double _calculateTotalAmount(List<Order>? orders) {
    if (orders == null || orders.isEmpty) {
      return 0.0;
    }
    return orders.fold(0.0, (sum, order) => sum + order.price);
  }
}
