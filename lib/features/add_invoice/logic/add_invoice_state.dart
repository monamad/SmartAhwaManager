part of 'add_invoice_cubit.dart';

abstract class AddInvoiceState {}

class AddInvoiceInitial extends AddInvoiceState {}

class AddInvoiceLoading extends AddInvoiceState {}

class AddOrderSuccess extends AddInvoiceState {}

class OrderRemoved extends AddInvoiceState {}

class AddInvoiceSuccess extends AddInvoiceState {}

class AddInvoiceError extends AddInvoiceState {
  final String message;

  AddInvoiceError(this.message);
}
