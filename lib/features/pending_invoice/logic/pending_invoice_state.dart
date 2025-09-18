part of 'pending_invoice_cubit.dart';

abstract class PendingInvoiceState {}

class PendingInvoiceInitial extends PendingInvoiceState {}

class PendingInvoiceLoading extends PendingInvoiceState {}

class PendingInvoiceLoaded extends PendingInvoiceState {
  final List<Invoice> invoices;

  PendingInvoiceLoaded(this.invoices);
}

class PendingInvoiceEmpty extends PendingInvoiceState {}

class InvoiceCompleted extends PendingInvoiceState {
  final Invoice completedInvoice;

  InvoiceCompleted(this.completedInvoice);
}

class PendingInvoiceError extends PendingInvoiceState {
  final String message;

  PendingInvoiceError(this.message);
}
