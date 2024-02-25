import '../models/foot_items.dart';

class FoodMenuViewModel {
  late List<FoodItem> foodItems;

  void fetchFoodItems() {
    foodItems = [
      FoodItem(name: 'Pizza', price: 10.99, image: 'assets/pizza.jpg'),
      FoodItem(name: 'Burger', price: 8.99, image: 'assets/burger.jpg'),
      FoodItem(name: 'Salad', price: 6.99, image: 'assets/salad.jpg'),
      FoodItem(name: 'Pasta', price: 12.99, image: 'assets/pasta.jpg'),
      FoodItem(name: 'Sushi', price: 15.99, image: 'assets/sushi.jpg'),
      FoodItem(name: 'Bread', price: 7.99, image: 'assets/sandwich.jpg'),
      FoodItem(name: 'Tacos', price: 9.99, image: 'assets/tacos.jpg'),
      FoodItem(name: 'Steak', price: 19.99, image: 'assets/steak.jpg'),
      FoodItem(name: 'Fried', price: 11.99, image: 'assets/fried_chicken.jpg'),
      FoodItem(name: 'Soup', price: 5.99, image: 'assets/soup.jpg'),
      FoodItem(name: 'Ramen', price: 13.99, image: 'assets/ramen.jpg'),
      FoodItem(name: 'Fish', price: 14.99, image: 'assets/fish_and_chips.jpg'),
      FoodItem(name: 'Udon', price: 11.99, image: 'assets/spaghetti.jpg'),
      FoodItem(name: 'Caesar', price: 8.99, image: 'assets/caesar_salad.jpg'),
    ];
  }

  Future<void> checkout(Map<FoodItem, int> orderedItems, double totalPrice) async {
    print('Ordered Items: $orderedItems');
    print('Total Price: $totalPrice');
  }
}
