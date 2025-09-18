import 'package:ass1/logic/cubit/app_cubit.dart';
import 'package:ass1/features/add_invoice/view/widgets/add_new_drink_view.dart';
import 'package:ass1/features/add_invoice/view/widgets/placed_orders_section_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddInvoiceView extends StatelessWidget {
  const AddInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Invoice')),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddNewDrinkView(),
              TextFormField(
                controller: context
                    .read<AppCubit>()
                    .specialInstructionsController,
                decoration: const InputDecoration(
                  labelText: 'Special Instructions',
                ),
              ),

              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return PlacedOrdersSection();
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (context.read<AppCubit>().orders.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please add at least one order'),
                      ),
                    );
                    return;
                  }
                  context.read<AppCubit>().submitInvoice();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invoice submitted')),
                  );
                  Navigator.pop(context);
                },
                child: Text('Submit invoice'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
