import 'package:flutter/material.dart';
import 'package:yama_shopping/modal/product.dart';

class Cart with ChangeNotifier {
  List<CartItem> items = [];

  int findItemById(String id) {
    var position = -1;
    for (var i = 0; i < items.length; i++) {
      if (items[i].product.id == id) {
        position = i;
      }
    }

    return position;
  }

  void add(Product newItem) {
    int position = findItemById(newItem.id);
    if (position != -1) {
      items[position].quantity += 1;
    } else {
      CartItem cartItem = CartItem(newItem, 1);
      items.add(cartItem);
    }
  }

  void delete(String id) {
    items.removeWhere((element) => element.product.id == id);
    notifyListeners();
  }

  int getTotal() => items.fold(0,
      (total, element) => total + (element.product.price * element.quantity));
}

class CartItem {
  Product product;
  int quantity;
  CartItem(this.product, this.quantity);
}
