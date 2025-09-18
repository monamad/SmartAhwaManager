import 'package:ass1/backend/menu/current_drinks.dart';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/data/models/order.dart';
import 'package:ass1/features/add_invoice/repo/interfaces/invoice_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_invoice_state.dart';

class AddInvoiceCubit extends Cubit<AddInvoiceState> {
  final InvoiceRepo invoiceRepo;

  AddInvoiceCubit(this.invoiceRepo) : super(AddInvoiceInitial());

  // Form controllers
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController specialInstructionsController =
      TextEditingController();
  final TextEditingController quantityController = TextEditingController()
    ..text = '1';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Private fields
  Drink? _selectedDrink = CurrentDrinks.drinks[27];
  final List<Order> _orders = [];

  // Getters
  Drink? get selectedDrink => _selectedDrink;
  List<Order> get orders => List.unmodifiable(_orders);

  // Setters
  set selectedDrink(Drink? drink) {
    _selectedDrink = drink;
  }

  void createOrder() {
    if (formKey.currentState?.validate() != true) {
      emit(AddInvoiceError('Please fix the errors in the form'));
      return;
    }

    if (_selectedDrink == null) {
      emit(AddInvoiceError('Please select a drink'));
      return;
    }

    final order = invoiceRepo.createOrder(
      _selectedDrink!,
      int.parse(quantityController.text),
    );

    _orders.add(order);
    quantityController.text = '1';
    specialInstructionsController.clear();
    emit(AddOrderSuccess());
  }

  void removeOrder(int index) {
    if (index >= 0 && index < _orders.length) {
      _orders.removeAt(index);
      emit(OrderRemoved());
    }
  }

  void submitInvoice() {
    if (_orders.isEmpty) {
      emit(AddInvoiceError('Please add at least one order'));
      return;
    }

    if (customerNameController.text.trim().isEmpty) {
      emit(AddInvoiceError('Please enter customer name'));
      return;
    }

    invoiceRepo.addInvoice({
      'customerName': customerNameController.text.trim(),
      'orders': List<Order>.from(_orders), // Create a copy of the orders list
      'specialInstructions': specialInstructionsController.text.trim(),
    });

    // Clear form
    customerNameController.clear();
    specialInstructionsController.clear();
    quantityController.text = '1';
    _orders.clear();
    _selectedDrink = CurrentDrinks.drinks[27];

    emit(AddInvoiceSuccess());
  }

  void clearForm() {
    customerNameController.clear();
    specialInstructionsController.clear();
    quantityController.text = '1';
    _orders.clear();
    _selectedDrink = CurrentDrinks.drinks[27];
    emit(AddInvoiceInitial());
  }

  @override
  Future<void> close() {
    customerNameController.dispose();
    specialInstructionsController.dispose();
    quantityController.dispose();
    return super.close();
  }
}
