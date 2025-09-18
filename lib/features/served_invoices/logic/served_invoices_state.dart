part of 'served_invoices_cubit.dart';

abstract class ServedInvoicesState {}

class ServedInvoicesInitial extends ServedInvoicesState {}

class ServedInvoicesLoading extends ServedInvoicesState {}

class ServedInvoicesLoaded extends ServedInvoicesState {
  final List<Invoice> invoices;

  ServedInvoicesLoaded(this.invoices);
}

class ServedInvoicesEmpty extends ServedInvoicesState {}

class ServedInvoicesError extends ServedInvoicesState {
  final String message;

  ServedInvoicesError(this.message);
}
