import 'package:flutter/material.dart';
import 'package:yama_shopping/modal/episode.dart';

class Cart with ChangeNotifier {
  List<CartItem> items = [];

  int findItemById(String episodeID) {
    var position = -1;
    for (var i = 0; i < items.length; i++) {
      if (items[i].episode.episodeID == episodeID) {
        position = i;
      }
    }
    return position;
  }

  void add(Episode newItem) {
    int position = findItemById(newItem.episodeID);
    if (position != -1) {
      items[position].quantity += 1;
    } else {
      CartItem cartItem = CartItem(newItem, 1);
      items.add(cartItem);
    }
  }

  void delete(String episodeID) {
    items.removeWhere((element) => element.episode.episodeID == episodeID);
    notifyListeners();
  }

  int getTotal() => items.fold(0,
      (total, element) => total + (element.episode.price * element.quantity));
}

class CartItem {
  Episode episode;
  int quantity;
  CartItem(this.episode, this.quantity);
}
