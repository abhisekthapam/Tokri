import 'package:flutter/material.dart';
import '../models/foot_items.dart';

class OrderPage extends StatelessWidget {
  final Map<FoodItem, int> orderedItems;
  final double totalPrice;

  OrderPage({required this.orderedItems, required this.totalPrice});

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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Total Price: \$${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
