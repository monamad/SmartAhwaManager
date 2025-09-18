import 'dart:collection';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'day_report_state.dart';

class DayReportCubit extends Cubit<DayReportState> {
  final AppRepo appRepo;

  DayReportCubit(this.appRepo) : super(DayReportInitial());

  void loadDayReport() {
    emit(DayReportLoading());
    try {
      final reportData = DayReportData(
        totalIncome: appRepo.totalIncome(),
        totalInvoicesServed: appRepo.totalInvoicesServed(),
        pendingInvoicesCount: appRepo.pendingInvoices.length,
        servedInvoicesCount: appRepo.servedInvoices.length,
        popularDrinks: appRepo.getPopularDrinks(),
        recentServedInvoices: appRepo.servedInvoices.take(5).toList(),
      );

      emit(DayReportLoaded(reportData));
    } catch (e) {
      emit(DayReportError('Failed to load day report: ${e.toString()}'));
    }
  }

  void refreshReport() {
    loadDayReport();
  }

  // Individual getters for specific data
  double get totalIncome => appRepo.totalIncome();
  int get totalInvoicesServed => appRepo.totalInvoicesServed();
  int get pendingInvoicesCount => appRepo.pendingInvoices.length;
  int get servedInvoicesCount => appRepo.servedInvoices.length;
  LinkedHashMap<Drink, int> get popularDrinks => appRepo.getPopularDrinks();
  List<Invoice> get recentServedInvoices =>
      appRepo.servedInvoices.take(5).toList();
}

class DayReportData {
  final double totalIncome;
  final int totalInvoicesServed;
  final int pendingInvoicesCount;
  final int servedInvoicesCount;
  final LinkedHashMap<Drink, int> popularDrinks;
  final List<Invoice> recentServedInvoices;

  DayReportData({
    required this.totalIncome,
    required this.totalInvoicesServed,
    required this.pendingInvoicesCount,
    required this.servedInvoicesCount,
    required this.popularDrinks,
    required this.recentServedInvoices,
  });
}
