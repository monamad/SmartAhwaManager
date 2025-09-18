import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/features/pending_invoice/logic/pending_invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingOrdersView extends StatefulWidget {
  const PendingOrdersView({super.key});

  @override
  State<PendingOrdersView> createState() => _PendingOrdersViewState();
}

class _PendingOrdersViewState extends State<PendingOrdersView> {
  @override
  void initState() {
    super.initState();
    context.read<PendingInvoiceCubit>().loadPendingInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Orders')),
      body: BlocBuilder<PendingInvoiceCubit, PendingInvoiceState>(
        builder: (context, state) {
          if (state is PendingInvoiceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PendingInvoiceError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading pending invoices',
                    style: TextStyle(fontSize: 18, color: Colors.red[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<PendingInvoiceCubit>()
                        .refreshPendingInvoices(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is PendingInvoiceEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 64, color: Colors.green),
                  SizedBox(height: 16),
                  Text(
                    'No pending orders! 🎉',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('All orders have been completed.'),
                ],
              ),
            );
          }

          final invoices = state is PendingInvoiceLoaded
              ? state.invoices
              : <Invoice>[];

          return ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  'Invoice #${invoices[index].id} - ${invoices[index].customerName}',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${invoices[index].createdAt.toLocal().toString().split(' ')[0]}',
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: invoices[index].orders
                          .map(
                            (order) => Text(
                              '- ${order.quantity} x ${order.drink.name} (\$${order.price.toStringAsFixed(2)})',
                            ),
                          )
                          .toList(),
                    ),
                    Text(
                      'Total: \$${invoices[index].totalAmount.toStringAsFixed(2)}',
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Completed Invoice #${invoices[index].id}',
                        ),
                      ),
                    );
                    print(invoices[index].orders.length);

                    context.read<PendingInvoiceCubit>().completeInvoice(
                      invoices[index],
                    );
                  },
                  child: const Text('Complete'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
