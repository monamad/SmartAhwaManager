import 'package:ass1/features/add_invoice/logic/add_invoice_cubit.dart';
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

              BlocBuilder<AddInvoiceCubit, AddInvoiceState>(
                builder: (context, state) {
                  return PlacedOrdersSection();
                },
              ),
              TextFormField(
                controller: context
                    .read<AddInvoiceCubit>()
                    .customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Write Customer Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: context
                    .read<AddInvoiceCubit>()
                    .specialInstructionsController,
                decoration: const InputDecoration(
                  labelText: 'Special Instructions',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (context.read<AddInvoiceCubit>().orders.isEmpty ||
                      context
                          .read<AddInvoiceCubit>()
                          .customerNameController
                          .text
                          .isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please add at least one order and customer name'),
                      ),
                    );
                    return;
                  }
                  context.read<AddInvoiceCubit>().submitInvoice();
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
