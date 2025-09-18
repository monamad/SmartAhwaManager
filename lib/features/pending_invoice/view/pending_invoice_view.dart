import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrdersView extends StatefulWidget {
  const PendingOrdersView({super.key});

  @override
  State<PendingOrdersView> createState() => _PendingOrdersViewState();
}

class _PendingOrdersViewState extends State<PendingOrdersView> {
  late List<Invoice> invoices;
  @override
  void initState() {
    invoices = context.read<AppCubit>().pendinginvoices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Orders')),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Invoice #${invoices[index].id} - ${invoices[index].customerName}',
            ),
            subtitle: Text(
              'Total: \$${invoices[index].totalAmount.toStringAsFixed(2)}',
            ),
            trailing: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Completed Invoice #${invoices[index].id}'),
                  ),
                );
                print(invoices[index].orders.length);

                context.read<AppCubit>().completeInvoice(invoices[index]);
                setState(() {
                  invoices = context.read<AppCubit>().pendinginvoices;
                });
              },
              child: const Text('Complete'),
            ),
          );
        },
      ),
    );
  }
}
