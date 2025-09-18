part of 'day_report_cubit.dart';

abstract class DayReportState {}

class DayReportInitial extends DayReportState {}

class DayReportLoading extends DayReportState {}

class DayReportLoaded extends DayReportState {
  final DayReportData reportData;

  DayReportLoaded(this.reportData);
}

class DayReportError extends DayReportState {
  final String message;

  DayReportError(this.message);
}
