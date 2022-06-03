import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/character.dart';

class CharacterService {
  Stream<QuerySnapshot> fetchRealtimeCharacters(String productID) {
    return FirebaseFirestore.instance
        .collection('character')
        .where('productID', isEqualTo: productID)
        .snapshots();
  }

  Future<String> addNewCharacter(Character character) async {
    try {
      await FirebaseFirestore.instance.collection("character").add({
        'characterID': character.characterID,
        'productID': character.productID,
        'image': character.image,
        'name': character.name,
      });
      return 'Add New Character successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }

  Future<String> deleteCharacter(String characterID) async {
    try {
      await FirebaseFirestore.instance
          .collection("character")
          .where('characterID', isEqualTo: characterID)
          .get()
          .then((events) => events.docs[0].reference.delete());
      return 'Delete character successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
