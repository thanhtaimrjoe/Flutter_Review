// import 'package:flutter/material.dart';
// import 'package:yama_shopping/modal/catalog.dart';

// class Cart with ChangeNotifier {
//   List<CartItem> items = [];

//   int findItemById(int id) {
//     var position = -1;
//     for (var i = 0; i < items.length; i++) {
//       if (items[i].item.id == id) {
//         position = i;
//       }
//     }

//     return position;
//   }

//   void add(Item newItem) {
//     int position = findItemById(newItem.id);
//     if (position != -1) {
//       items[position].quantity += 1;
//     } else {
//       CartItem cartItem = CartItem(newItem, 1);
//       items.add(cartItem);
//     }
//   }

//   void delete(int id) {
//     items.removeWhere((element) => element.item.id == id);
//     notifyListeners();
//   }

//   // int getTotal() => items.fold(
//   //     0, (total, element) => total + (element.item.price * element.quantity));
// }

// class CartItem {
//   Item item;
//   int quantity;
//   CartItem(this.item, this.quantity);
// }
