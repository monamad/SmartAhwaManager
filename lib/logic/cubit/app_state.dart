part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AddInvoiceInitial extends AppState {}

final class AddOrderSuccess extends AppState {}

final class AddInvoiceSuccess extends AppState {}

final class AddInvoiceError extends AppState {
  final String message;
  AddInvoiceError(this.message);
}
