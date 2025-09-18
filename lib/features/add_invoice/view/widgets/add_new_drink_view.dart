import 'package:ass1/logic/cubit/app_cubit.dart';
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
          key: context.read<AppCubit>().formKey,
          child: Column(
            children: [
              TextFormField(
                controller: context.read<AppCubit>().customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Write Customer Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              SelectDrinkSection(
                onChanged: (drink) {
                  context.read<AppCubit>().selectedDrink = drink;
                },
              ),
              const SizedBox(height: 8),

              const SizedBox(height: 16),
              TextFormField(
                controller: context.read<AppCubit>().quantityController,
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
            final formState = context.read<AppCubit>().formKey.currentState;
            if (formState != null && formState.validate()) {
              print('Form is valid');
              context.read<AppCubit>().createOrder();
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
