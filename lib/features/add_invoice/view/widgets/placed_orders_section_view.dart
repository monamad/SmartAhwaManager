import 'package:ass1/data/models/order.dart';
import 'package:ass1/logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacedOrdersSection extends StatelessWidget {
  const PlacedOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Placed Orders', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: context.read<AppCubit>().orders.length,
          itemBuilder: (context, index) {
            return OrderTile(order: context.read<AppCubit>().orders[index]);
          },
        ),
      ],
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(order.drink.name),
      subtitle: Text('Quantity: ${order.quantity}'),
      trailing: Text('\$${order.price.toStringAsFixed(2)}'),
    );
  }
}
