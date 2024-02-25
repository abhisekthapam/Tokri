import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/foot_items.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder(Map<FoodItem, int> orderedItems, double totalPrice) async {
    try {
      // Create a new document in the "orders" collection
      DocumentReference orderRef = await _firestore.collection('orders').add({
        'totalPrice': totalPrice,
        'orderedItems': orderedItems.entries.map((entry) => {
          'itemName': entry.key.name,
          'quantity': entry.value,
          'pricePerItem': entry.key.price,
        }).toList(),
        'createdAt': DateTime.now(),
      });

      print('Order saved with ID: ${orderRef.id}');
    } catch (e) {
      print('Error saving order: $e');
    }
  }
}
