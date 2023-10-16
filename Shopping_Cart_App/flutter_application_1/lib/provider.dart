import 'package:flutter/material.dart';
import 'package:shopping_cart/model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> cartItems = [];
  List<Product> get cartlist => cartItems;

  final List<Product> items = [
    Product(id: 1, name: 'Product 1', price: 10.0, quantity: 2),
    Product(id: 2, name: 'Product 2', price: 15.0, quantity: 2),
    Product(id: 2, name: 'Product 3', price: 20.0, quantity: 2),
  ];

  List<Product> get itemslist => items;

  void add(Product p) {
    cartItems.add(p);
    notifyListeners();
  }

  void remove(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  double calculateTotalCost() {
    double totalCost = 0.0;
    for (final product in items) {
      totalCost += (product.price * product.quantity);
    }
    return totalCost;
  }
}
