import 'package:ass1/backend/menu/current_drinks.dart';
import 'package:ass1/data/models/drink.dart';
import 'package:flutter/material.dart';

class SelectDrinkSection extends StatelessWidget {
  final void Function(Drink) onChanged;
  const SelectDrinkSection({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<Drink>(
          initialValue: CurrentDrinks.drinks[27],
          decoration: const InputDecoration(labelText: 'Select Drink'),
          items: CurrentDrinks.drinks
              .map(
                (drink) => DropdownMenuItem<Drink>(
                  value: drink,
                  child: Text(
                    '${drink.name} - \$${drink.price.toStringAsFixed(2)}',
                  ),
                ),
              )
              .toList(),

          onChanged: (value) => onChanged(value!),
          validator: (newValue) {
            if (newValue == null) {
              return 'select Drink';
            }
            return null;
          },
        ),
      ],
    );
  }
}
