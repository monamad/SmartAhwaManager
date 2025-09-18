import 'dart:collection';
import 'package:ass1/data/models/drink.dart';
import 'package:ass1/repo/app_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_drinks_state.dart';

class PopularDrinksCubit extends Cubit<PopularDrinksState> {
  final AppRepo appRepo;

  PopularDrinksCubit(this.appRepo) : super(PopularDrinksInitial());

  void loadPopularDrinks() {
    emit(PopularDrinksLoading());
    try {
      final drinks = appRepo.getPopularDrinks();
      if (drinks.isEmpty) {
        emit(PopularDrinksEmpty());
      } else {
        emit(PopularDrinksLoaded(drinks));
      }
    } catch (e) {
      emit(
        PopularDrinksError('Failed to load popular drinks: ${e.toString()}'),
      );
    }
  }

  void refreshPopularDrinks() {
    loadPopularDrinks();
  }

  LinkedHashMap<Drink, int> get popularDrinks => appRepo.getPopularDrinks();
}
