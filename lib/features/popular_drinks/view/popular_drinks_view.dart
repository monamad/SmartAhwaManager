import 'dart:collection';

import 'package:ass1/data/models/drink.dart';
import 'package:ass1/logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularDrinksView extends StatefulWidget {
  const PopularDrinksView({super.key});

  @override
  State<PopularDrinksView> createState() => _PopularDrinksViewState();
}

class _PopularDrinksViewState extends State<PopularDrinksView> {
  late LinkedHashMap<Drink, int> popularDrinks;
  @override
  void initState() {
    popularDrinks = context.read<AppCubit>().popularDrinks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Drinks')),
      body: ListView.builder(
        itemCount: popularDrinks.length,
        itemBuilder: (context, index) {
          final drink = popularDrinks.keys.elementAt(index);
          final quantity = popularDrinks[drink];
          return ListTile(
            title: Text(drink.name),
            subtitle: Text('Quantity: $quantity'),
          );
        },
      ),
    );
  }
}
