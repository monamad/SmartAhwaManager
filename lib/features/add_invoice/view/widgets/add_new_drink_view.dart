import 'package:ass1/features/add_invoice/logic/add_invoice_cubit.dart';
import 'package:ass1/features/add_invoice/view/widgets/select_drink_section_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewDrinkView extends StatelessWidget {
  const AddNewDrinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: context.read<AddInvoiceCubit>().formKey,
          child: Column(
            children: [
             
              const SizedBox(height: 8),
              SelectDrinkSection(
                onChanged: (drink) {
                  context.read<AddInvoiceCubit>().selectedDrink = drink;
                },
              ),
              const SizedBox(height: 8),

              const SizedBox(height: 16),
              TextFormField(
                controller: context.read<AddInvoiceCubit>().quantityController,
                decoration: const InputDecoration(labelText: 'quantity'),
                validator: (value) {
                  return null;
                },
              ),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: () {
            final formState = context
                .read<AddInvoiceCubit>()
                .formKey
                .currentState;
            if (formState != null && formState.validate()) {
              print('Form is valid');
              context.read<AddInvoiceCubit>().createOrder();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order created successfully')),
              );
            }
          },
          child: const Text('submit drink'),
        ),
      ],
    );
  }
}
