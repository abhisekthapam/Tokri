import 'package:flutter/material.dart';
import '../models/foot_items.dart';
import '../view_models/food_menu_view_model.dart';
import '../view_models/order_service.dart'; // Import the OrderService
import 'checkout_page.dart';
import 'order_page.dart';

class FoodMenuPage extends StatefulWidget {
  @override
  _FoodMenuPageState createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  final FoodMenuViewModel viewModel = FoodMenuViewModel();
  Map<FoodItem, int> orderedItems = {};
  final OrderService orderService = OrderService(); // Instantiate OrderService

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

  void placeOrder(BuildContext context) async {
    final totalPrice = calculateTotalPrice();
    await orderService.saveOrder(orderedItems, totalPrice); // Call saveOrder method
    setState(() {
      orderedItems.clear();
    });
    Navigator.pop(context); // Close the dialog
    Navigator.push( // Navigate to checkout_page.dart
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(),
      ),
    );
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: orderedItems.isEmpty ? null : () {
                  Navigator.push( // Navigate to the OrderPage
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPage(orderedItems: orderedItems, totalPrice: calculateTotalPrice()),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart),
                label: Text('View Order (${orderedItems.length})'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: orderedItems.isNotEmpty ? () async {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Ordered Items:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: orderedItems.entries.map((entry) => Text('${entry.key.name}: ${entry.value}')).toList(),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () => placeOrder(context), // Call placeOrder method
                                  child: Text(
                                    'Order',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } : null,
                icon: Icon(Icons.shopping_cart),
                label: Text('Checkout'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
