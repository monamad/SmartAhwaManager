import 'package:ass1/data/models/invoice.dart';

abstract class Storage {
  List<Invoice> get pendingInvoices;
  List<Invoice> get completedInvoices;

  void addPendingInvoice(Invoice invoice);
  void removePendingInvoice(int invoiceindex);
  void addCompletedInvoice(Invoice invoice);
  void clearStorage();
}
