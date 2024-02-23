import '../models/foot_items.dart';

class FoodMenuViewModel {
  List<FoodItem> foodItems = [];

  void fetchFoodItems() {
    // For demonstration purposes, adding dummy data directly
    foodItems = [
      FoodItem(name: 'Burger', price: 5.99),
      FoodItem(name: 'Pizza', price: 8.99),
      FoodItem(name: 'Salad', price: 4.99),
    ];
  }
}
