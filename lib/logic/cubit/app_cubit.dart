import 'dart:collection';

import 'package:ass1/backend/menu/current_drinks.dart';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/data/models/order.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppRepo appRepo;
  AppCubit(this.appRepo) : super(AddInvoiceInitial());

  TextEditingController customerNameController = TextEditingController();
  TextEditingController specialInstructionsController = TextEditingController();
  TextEditingController quantityController = TextEditingController()
    ..text = '1';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Drink? _selectedDrink = CurrentDrinks.drinks[27];

  List<Order> orders = [];
  void submitInvoice() {
    appRepo.addInvoice({
      'customerName': customerNameController.text,
      'orders': List<Order>.from(orders), // Create a copy of the orders list
      'specialInstructions': specialInstructionsController.text,
    });
    customerNameController.clear();
    specialInstructionsController.clear();
    quantityController.text = '1';
    orders.clear();
    emit(AddInvoiceSuccess());
  }

  void createOrder() {
    if (formKey.currentState?.validate() != true) {
      emit(AddInvoiceError('Please fix the errors in the form'));
      return;
    }

    final order = appRepo.createOrder(
      _selectedDrink!,
      int.parse(quantityController.text),
    );
    orders.add(order);
    quantityController.text = '1';
    specialInstructionsController.clear();
    emit(AddOrderSuccess());
  }

  set selectedDrink(Drink drink) {
    _selectedDrink = drink;
  }

  List<Invoice> get pendinginvoices => appRepo.pendingInvoices;
  List<Invoice> get servedInvoices => appRepo.servedInvoices;

  void completeInvoice(Invoice invoice) {
    print('xxxxxxxxxxerwr');
    print(invoice.orders.length);
    appRepo.backendServices.completeInvoice(invoice);
  }

  LinkedHashMap<Drink, int> get popularDrinks => appRepo.getPopularDrinks();

  // Additional report methods
  double get totalIncome => appRepo.backendServices.totalIncome();
  int get totalInvoicesServed => appRepo.backendServices.totalInvoicesServed();
  int get pendingInvoicesCount => pendinginvoices.length;
  int get servedInvoicesCount => servedInvoices.length;
}
