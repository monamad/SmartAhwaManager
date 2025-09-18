import 'dart:collection';

import 'package:ass1/data/models/drink.dart';
import 'package:ass1/features/popular_drinks/logic/popular_drinks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularDrinksView extends StatefulWidget {
  const PopularDrinksView({super.key});

  @override
  State<PopularDrinksView> createState() => _PopularDrinksViewState();
}

class _PopularDrinksViewState extends State<PopularDrinksView> {
  @override
  void initState() {
    super.initState();
    context.read<PopularDrinksCubit>().loadPopularDrinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Drinks')),
      body: BlocBuilder<PopularDrinksCubit, PopularDrinksState>(
        builder: (context, state) {
          if (state is PopularDrinksLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PopularDrinksError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading popular drinks',
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
                        .read<PopularDrinksCubit>()
                        .refreshPopularDrinks(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is PopularDrinksEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_cafe, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No popular drinks yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Complete some orders to see popular drinks.'),
                ],
              ),
            );
          }

          final popularDrinks = state is PopularDrinksLoaded
              ? state.drinks
              : LinkedHashMap<Drink, int>();

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PopularDrinksCubit>().refreshPopularDrinks();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: ListView.builder(
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
        },
      ),
    );
  }
}
