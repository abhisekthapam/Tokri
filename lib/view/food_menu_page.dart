import 'package:flutter/material.dart';
import '../models/foot_items.dart';
import '../view_models/food_menu_view_model.dart';

class FoodMenuPage extends StatefulWidget {
  @override
  _FoodMenuPageState createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  final FoodMenuViewModel viewModel = FoodMenuViewModel();
  Map<FoodItem, int> orderedItems = {};
  @override
  void initState() {
    super.initState();
    viewModel.fetchFoodItems();
  }

  void addToOrder(FoodItem item) {
    setState(() {
      if (orderedItems.containsKey(item)) {
        orderedItems[item] = orderedItems[item]! + 1;
      } else {
        orderedItems[item] = 1;
      }
    });
  }

  void removeFromOrder(FoodItem item) {
    setState(() {
      if (orderedItems.containsKey(item)) {
        if (orderedItems[item]! > 1) {
          orderedItems[item] = orderedItems[item]! - 1;
        } else {
          orderedItems.remove(item);
        }
      }
    });
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    orderedItems.forEach((item, quantity) {
      totalPrice += item.price * quantity;
    });
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Menu'),
      ),
      body: ListView.builder(
        itemCount: viewModel.foodItems.length,
        itemBuilder: (context, index) {
          final foodItem = viewModel.foodItems[index];
          final quantity = orderedItems[foodItem] ?? 0;
          return ListTile(
            title: Text(foodItem.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$${foodItem.price.toString()}'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => removeFromOrder(foodItem),
                    ),
                    Text(
                      quantity.toString(),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => addToOrder(foodItem),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderPage(orderedItems: orderedItems),
            ),
          );
        },
        label: Text('View Order (${orderedItems.length})'),
        icon: Icon(Icons.shopping_cart),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {
                  // Perform action when "Checkout" button is pressed
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class OrderPage extends StatelessWidget {
  final Map<FoodItem, int> orderedItems;

  OrderPage({required this.orderedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordered Items'),
      ),
      body: ListView.builder(
        itemCount: orderedItems.length,
        itemBuilder: (context, index) {
          final foodItem = orderedItems.keys.elementAt(index);
          final quantity = orderedItems.values.elementAt(index);
          return ListTile(
            title: Text(foodItem.name),
            subtitle: Text('Quantity: $quantity, Price: \$${(foodItem.price * quantity).toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
