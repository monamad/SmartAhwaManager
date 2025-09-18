import 'package:ass1/data/models/drink.dart';

class Order {
  final Drink drink;
  final int quantity;

  final double price;

  Order({
    required this.price,
    required this.quantity,
    required this.drink,

  });
}
