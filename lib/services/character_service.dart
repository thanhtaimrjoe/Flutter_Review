import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/modal/character.dart';

class CharacterService {
  Future<Character> findCharactersByProductID(String productID) async {
    Character result = Character(productID, []);
    try {
      await FirebaseFirestore.instance
          .collection("character")
          .where('productID', isEqualTo: productID)
          .get()
          .then((event) {
        result = Character.fromJSON(event.docs[0].data());
      });
      return result;
    } catch (e) {
      return result;
    }
  }
}
