import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/data/models/order.dart';

class InvoiceService {
  Invoice generateInvoice(
    List<Order> orders,
    String customerName,
    String? specialInstructions,
  ) {
    double totalAmount = 0;
    for (var order in orders) {
      totalAmount += order.price * order.quantity;
    }
    return Invoice(
      customerName: customerName,
      orders: orders,
      specialInstructions: specialInstructions,
      totalAmount: totalAmount,
      createdAt: DateTime.now(),
    );
  }
}
