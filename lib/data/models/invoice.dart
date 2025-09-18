import 'package:ass1/data/models/order.dart';

class Invoice {
  late int id;
  final String customerName;
  final List<Order> orders;
  final String? specialInstructions;
  final double totalAmount;
  final DateTime createdAt;
  InvoiceStatus invoiceStatus;

  Invoice({
    required this.createdAt,

    required this.customerName,
    required this.orders,
    this.specialInstructions,
    required this.totalAmount,
    this.invoiceStatus = InvoiceStatus.pending,
  });
}
enum InvoiceStatus { pending, completed }
