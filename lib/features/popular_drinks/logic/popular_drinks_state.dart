part of 'popular_drinks_cubit.dart';

abstract class PopularDrinksState {}

class PopularDrinksInitial extends PopularDrinksState {}

class PopularDrinksLoading extends PopularDrinksState {}

class PopularDrinksLoaded extends PopularDrinksState {
  final LinkedHashMap<Drink, int> drinks;

  PopularDrinksLoaded(this.drinks);
}

class PopularDrinksEmpty extends PopularDrinksState {}

class PopularDrinksError extends PopularDrinksState {
  final String message;

  PopularDrinksError(this.message);
}
