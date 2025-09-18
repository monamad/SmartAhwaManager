import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'served_invoices_state.dart';

class ServedInvoicesCubit extends Cubit<ServedInvoicesState> {
  final AppRepo appRepo;

  ServedInvoicesCubit(this.appRepo) : super(ServedInvoicesInitial());

  List<Invoice> get servedInvoices => appRepo.servedInvoices;

  void loadServedInvoices() {
    emit(ServedInvoicesLoading());
    try {
      final invoices = appRepo.servedInvoices;
      if (invoices.isEmpty) {
        emit(ServedInvoicesEmpty());
      } else {
        emit(ServedInvoicesLoaded(invoices));
      }
    } catch (e) {
      emit(
        ServedInvoicesError('Failed to load served invoices: ${e.toString()}'),
      );
    }
  }

  void refreshServedInvoices() {
    loadServedInvoices();
  }

  Invoice? getInvoiceById(int id) {
    try {
      return servedInvoices.firstWhere((invoice) => invoice.id == id);
    } catch (e) {
      return null;
    }
  }
}
