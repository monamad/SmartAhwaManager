import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/features/served_invoices/logic/served_invoices_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServedInvoices extends StatefulWidget {
  const ServedInvoices({super.key});

  @override
  State<ServedInvoices> createState() => _ServedInvoicesState();
}

class _ServedInvoicesState extends State<ServedInvoices> {
  @override
  void initState() {
    super.initState();
    context.read<ServedInvoicesCubit>().loadServedInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Served Orders')),
      body: BlocBuilder<ServedInvoicesCubit, ServedInvoicesState>(
        builder: (context, state) {
          if (state is ServedInvoicesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServedInvoicesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading served invoices',
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
                        .read<ServedInvoicesCubit>()
                        .refreshServedInvoices(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ServedInvoicesEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No served orders yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Complete some orders to see them here.'),
                ],
              ),
            );
          }

          final invoices = state is ServedInvoicesLoaded
              ? state.invoices
              : <Invoice>[];

          return ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.check, color: Colors.green[700]),
                  ),
                  title: Text(
                    'Invoice #${invoices[index].id} - ${invoices[index].customerName}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
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
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
