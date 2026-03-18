import 'package:flutter/material.dart';
import '../models/cart.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  double _discount = 0.0;
  String? _appliedPromo;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total - _discount;
  }

  double get subtotal {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  double get discount => _discount;

  String? get appliedPromo => _appliedPromo;

  bool applyPromoCode(String code) {
    if (code.toUpperCase() == 'LUXE20') {
      _discount = subtotal * 0.20;
      _appliedPromo = code.toUpperCase();
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromoCode() {
    _discount = 0.0;
    _appliedPromo = null;
    notifyListeners();
  }

  void addItem(String productId, double price, String title, String imageUrl) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          imageUrl: existingCartItem.imageUrl.isEmpty ? imageUrl : existingCartItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    if (_items.isEmpty) removePromoCode();
    notifyListeners();
  }

  void clear() {
    _items = {};
    _discount = 0.0;
    _appliedPromo = null;
    notifyListeners();
  }
}
