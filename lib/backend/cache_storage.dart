import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/backend/interfaces/storage_interface.dart';

class CacheStorage implements Storage {
  final List<Invoice> _pendingInvoices = [];
  final List<Invoice> _completedInvoices = [];

  @override
  List<Invoice> get pendingInvoices => _pendingInvoices;

  @override
  List<Invoice> get completedInvoices => _completedInvoices;

  @override
  void addPendingInvoice(Invoice invoice) {
    _pendingInvoices.add(invoice);
  }

  @override
  void removePendingInvoice(int invoiceindex) {
    _pendingInvoices.removeAt(invoiceindex);
  }

  @override
  void addCompletedInvoice(Invoice invoice) {
    _completedInvoices.add(invoice);
  }

  @override
  void clearStorage() {
    _pendingInvoices.clear();
    _completedInvoices.clear();
  }
}
