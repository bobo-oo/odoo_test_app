import 'package:flutter/foundation.dart';

class CartLists {
  final String id;
  final String name;
  final int quantity;
  final double price;

  CartLists({
    this.id,
    this.name,
    this.quantity,
    this.price
  });
}

class Cart with ChangeNotifier {
  Map<String, CartLists> _items = {};

  Map<String, CartLists> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pId, String name, double price) {
    if (_items.containsKey(pId)) {
      _items.update(
          pId, (existingCartItem) =>
          CartLists(
              id: pId,
              name: existingCartItem.name,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          pId, () =>
          CartLists(
              id: pId,
              name: name,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }
  void updateQuantity(String pId, int qty) {
    _items.update(
        pId,
            (existingCartItem) =>
            CartLists(
                id: pId,
                name: existingCartItem.name,
                quantity: qty,
                price: existingCartItem.price));
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return ;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
              (existingCartItem) =>
              CartLists(
                  id: id,
                  name: existingCartItem.name,
                  quantity: existingCartItem.quantity - 1,
                  price: existingCartItem.price));
    }
    notifyListeners();
  }

  double get totalAmount {
    double ttl = 0.0;
    _items.forEach((key, cartItem) {
      ttl += cartItem.price * cartItem.quantity;
    });
    return ttl;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}