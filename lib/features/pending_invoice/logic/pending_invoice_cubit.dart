import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pending_invoice_state.dart';

class PendingInvoiceCubit extends Cubit<PendingInvoiceState> {
  final AppRepo appRepo;

  PendingInvoiceCubit(this.appRepo) : super(PendingInvoiceInitial());

  List<Invoice> get pendingInvoices => appRepo.pendingInvoices;

  void loadPendingInvoices() {
    emit(PendingInvoiceLoading());
    try {
      final invoices = appRepo.pendingInvoices;
      if (invoices.isEmpty) {
        emit(PendingInvoiceEmpty());
      } else {
        emit(PendingInvoiceLoaded(invoices));
      }
    } catch (e) {
      emit(
        PendingInvoiceError('Failed to load pending invoices: ${e.toString()}'),
      );
    }
  }

  void completeInvoice(Invoice invoice) {
    emit(PendingInvoiceLoading());
    try {
      appRepo.backendServices.completeInvoice(invoice);
      loadPendingInvoices(); // Reload the list
      emit(InvoiceCompleted(invoice));
    } catch (e) {
      emit(PendingInvoiceError('Failed to complete invoice: ${e.toString()}'));
    }
  }

  void refreshPendingInvoices() {
    loadPendingInvoices();
  }
}
