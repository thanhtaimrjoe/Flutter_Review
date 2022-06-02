import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/modal/character.dart';

class CharacterService {
  Future<List<dynamic>> findCharactersByProductID(String productID) async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("character")
          .where('productID', isEqualTo: productID)
          .get()
          .then((event) {
        result = event.docs
            .map((character) => Character.fromJSON(character.data()))
            .toList();
      });
      return result;
    } catch (e) {
      return [];
    }
  }
}
