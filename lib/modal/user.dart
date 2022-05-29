import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String username;
  String password;
  String fullname;
  String avatar;

  User(this.username, this.password, this.fullname, this.avatar);

  void addUser(User user) {
    username = user.username;
    password = user.password;
    fullname = user.fullname;
    avatar = user.avatar;
    notifyListeners();
  }

  User.fromJSON(Map<String, dynamic> parsedJSON)
      : username = parsedJSON['username'],
        password = parsedJSON['password'],
        fullname = parsedJSON['fullname'],
        avatar = parsedJSON['avatar'];
}
