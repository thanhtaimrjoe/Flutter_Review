import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/character.dart';

class CharacterService {
  Stream<QuerySnapshot> fetchRealtimeCharacters(String productID) {
    return FirebaseFirestore.instance
        .collection('character')
        .where('productID', isEqualTo: productID)
        .snapshots();
  }

  Future<String> addNewCharacter(Character character, String productID) async {
    try {
      await FirebaseFirestore.instance
          .collection("character")
          .doc(productID + 'asdqwe')
          .set({
        'productID': productID,
        'image': character.image,
        'name': character.name,
      });
      return 'Add New Character successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
