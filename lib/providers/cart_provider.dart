import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalSum {
    var totalSum = 0.0;
    _items.forEach((key, cartItem) {
      totalSum += cartItem.price * cartItem.quantity;
    });
    return totalSum;
  }

  void addItem(String productId, double price, String name) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          name: name,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    _items[productId].quantity == 1
        ? _items.remove(productId)
        : _items.update(
            productId,
            (existingProduct) => CartItem(
              id: existingProduct.id,
              name: existingProduct.name,
              quantity: existingProduct.quantity - 1,
              price: existingProduct.price,
            ),
          );
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
