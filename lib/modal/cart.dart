import 'package:flutter/material.dart';
import 'package:yama_shopping/modal/product.dart';

class Cart with ChangeNotifier {
  List<CartItem> items = [];

  int findItemById(String id) {
    var position = -1;
    for (var i = 0; i < items.length; i++) {
      if (items[i].productItem.id == id) {
        position = i;
      }
    }

    return position;
  }

  void add(ProductItem newItem) {
    int position = findItemById(newItem.id);
    if (position != -1) {
      items[position].quantity += 1;
    } else {
      CartItem cartItem = CartItem(newItem, 1);
      items.add(cartItem);
    }
  }

  void delete(String id) {
    items.removeWhere((element) => element.productItem.id == id);
    notifyListeners();
  }

  int getTotal() => items.fold(
      0,
      (total, element) =>
          total + (element.productItem.price * element.quantity));
}

class CartItem {
  ProductItem productItem;
  int quantity;
  CartItem(this.productItem, this.quantity);
}
