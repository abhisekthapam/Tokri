import '../models/foot_items.dart';

class FoodMenuViewModel {
  late List<FoodItem> foodItems;

  void fetchFoodItems() {
    // Simulate fetching food items from a data source
    foodItems = [
      FoodItem(name: 'Pizza', price: 10.99),
      FoodItem(name: 'Burger', price: 8.99),
      FoodItem(name: 'Salad', price: 6.99),
    ];
  }

  Future<void> checkout(Map<FoodItem, int> orderedItems, double totalPrice) async {
    // Perform checkout logic here, such as sending order details to Firebase
    // For demonstration, let's print the order details
    print('Ordered Items: $orderedItems');
    print('Total Price: $totalPrice');
  }
}
