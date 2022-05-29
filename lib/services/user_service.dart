import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/user.dart';

class UserService {
  Future<User> checkUserExist(String username, String password) async {
    User result = User('', '', '', '');
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get()
          .then((event) {
        result = User.fromJSON(event.docs[0].data());
      });
      return result;
    } catch (e) {
      return result;
    }
  }
}
