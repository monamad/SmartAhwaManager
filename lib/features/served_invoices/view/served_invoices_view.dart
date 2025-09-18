import 'package:ass1/data/models/invoice.dart';
import 'package:ass1/logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServedInvoices extends StatefulWidget {
  const ServedInvoices({super.key});

  @override
  State<ServedInvoices> createState() => _PopularDrinksState();
}

class _PopularDrinksState extends State<ServedInvoices> {
  late List<Invoice> invoices;
  @override
  void initState() {
    invoices = context.read<AppCubit>().servedInvoices;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Orders')),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          print('ssss');
          return ListTile(
            title: Text(
              'Invoice #${invoices[index].id} - ${invoices[index].customerName}',
            ),
            subtitle: Text(
              'Total: \$${invoices[index].totalAmount.toStringAsFixed(2)}',
            ),
          );
        },
      ),
    );
  }
}
