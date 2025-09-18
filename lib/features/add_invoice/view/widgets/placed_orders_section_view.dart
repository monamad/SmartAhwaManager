import 'package:ass1/data/models/order.dart';
import 'package:ass1/features/add_invoice/logic/add_invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacedOrdersSection extends StatelessWidget {
  const PlacedOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddInvoiceCubit, AddInvoiceState>(
      builder: (context, state) {
        final orders = context.read<AddInvoiceCubit>().orders;

        return Column(
          children: [
            Text(
              'Placed Orders',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (orders.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No orders added yet',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderTile(
                    order: orders[index],
                    onRemove: () =>
                        context.read<AddInvoiceCubit>().removeOrder(index),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;
  final VoidCallback? onRemove;

  const OrderTile({super.key, required this.order, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(order.drink.name),
        subtitle: Text('Quantity: ${order.quantity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$${order.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onRemove,
                tooltip: 'Remove order',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
